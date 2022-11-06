// This file loads functions used by the installer depeding on which OS is being used.
// all the func names have to be the same across all system variants for the main
// script to be able to run correctly. Please take note of this if making a pull
// request

// or fix this insane system i've come up with lol

pub mod standard_helpers {
    use colored::*;
    use predicates::prelude::*;
    use std::env;
    use std::fs;
    use std::io;
    use std::io::stdin;
    use std::io::stdout;
    use std::io::Read;
    use std::io::Write;
    use std::path::Path;
    use std::path::PathBuf;

    #[cfg(target_os = "windows")]
    use std::os::windows::fs::symlink_dir;

    #[cfg(target_family = "unix")]
    use std::os::unix::fs::symlink as symlink_dir;

    pub fn pause() {
       let mut stdout = stdout();
        stdout.write(b"Press Enter to continue...").unwrap();
        stdout.flush().unwrap();
        stdin().read(&mut [0]).unwrap();
    }

    pub fn backup_old_config(config_path: PathBuf) {
        println!("{}", "\n \nSTEP 1: Backing up old config".blue().bold());
        println!("{} {}", "Current OS is", env::consts::OS); // Prints the current OS.

        // Change process directory to the systems config folder
        match env::set_current_dir(config_path.as_path()) {
            Ok(()) => println!(
                "Changed process to config directory: {}",
                config_path.display()
            ),
            Err(err) => println!(
                "{} {}",
                "Error: couldn't locate config directory {}".red().bold(),
                err
            ),
        }

        // Rename the nvim folder to nvim.old (backup)
        println!("{}", "Trying to rename nvim folder...");
        match fs::rename("nvim", "nvim.old") {
            Ok(()) => {
                println!("Old config back up complete \n \n")
            }
            Err(_) => {
                println!(
                    "{}",
                    "You don't have an old config to back up. Skipping... \n \n"
                        .red()
                        .bold()
                )
            }
        }
    }

    #[cfg(target_os = "linux")]
    pub fn clone_config_repo() {
        let repo_url = "https://github.com/Sewdohe/NeoCode";
        std::process::Command::new("git")
            .arg("clone")
            .arg(repo_url)
            .arg("NeoCode")
            .spawn()
            .expect("Error: couldn't clone repo")
            .wait()
            .expect("Error: please try again");
    }

    #[cfg(target_os = "unix")]
    pub fn clone_config_repo() {
        let repo_url = "https://github.com/Sewdohe/NeoCode";
        std::process::Command::new("git")
            .arg("clone")
            .arg(repo_url)
            .arg("NeoCode")
            .spawn()
            .expect("Error: couldn't clone repo")
            .wait()
            .expect("Error: please try again");
    }

    #[cfg(target_os = "windows")]
    pub fn clone_config_repo() {
        let repo_url = "https://github.com/Sewdohe/NeoCode";
        std::process::Command::new("git")
            .arg("clone")
            .arg(repo_url)
            .arg("NeoCode")
            .spawn()
            .expect("Error: couldn't clone repo")
            .wait()
            .expect("Error: please try again");
    }

    pub fn determine_config_path() -> PathBuf {
        let os = env::consts::OS;
        let mut config_path = get_home_dir();
        if os == "windows" {
            config_path.push("AppData");
            config_path.push("Local");
            return config_path;
        } else if os == "linux" {
            // set URL for unix config
            config_path.push(".config");
            return config_path;
        } else if os == "macos" {
            // set URL for unix config
            config_path.push(".config");
            return config_path;
        } else {
            println!("Something is wrong!");
            // this is a terrible way to handle errors
            // TODO:
            return PathBuf::from("");
        }
    }

    pub fn symlink_config(mut config_path: PathBuf, starting_dir: &mut PathBuf) {
        println!(
            "{}",
            "STEP 2: Symlinking NeoCode config to config directory: "
                .blue()
                .bold()
        );
        // Backup complete. CD back to starting directory
        let os = env::consts::OS;
        match env::set_current_dir(starting_dir.as_path()) {
            Ok(()) => println!("Process went back to starting directory"),
            Err(err) => println!(
                "{} {}",
                "Error: Couldn't return to starting directory {}"
                    .red()
                    .bold(),
                err
            ),
        }

        let mut neocode_directory: PathBuf = starting_dir.to_path_buf();
        neocode_directory.push("NeoCode");

        config_path.push("nvim");

        // Symlink the config directory now
        if os == "windows" {
            println!(
                "trying to [windows] symlink {} to {}",
                "Neocode folder",
                config_path.display()
            );

            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            // This basically says, IF config path is already a symlink...
            match predicate_fn.eval(config_path.as_path()) {
                true => {
                    // then give the user an error
                    println!("Neovim folder is already symlinked to somewhere...maybe try deleting that first?")
                }
                false => {
                    // else, symlink the folder to the config
                    println!("Neovim folder is not already a symlink, we gucci.")
                }
            }
        } else if os == "linux" {
            println!(
                "trying to symlink {} to {}",
                neocode_directory.display(),
                config_path.display()
            );

            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            match symlink_dir(neocode_directory, config_path.as_path()) {
                Ok(()) => println!("{}", "Symlink done ------------------- \n \n".red().bold()),
                Err(err) => println!("Error Symlink: {}", err),
            }
        } else if os == "macos" {
            println!(
                "trying to [macOS] symlink {} to {}",
                neocode_directory.display(),
                config_path.display()
            );

            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            match symlink_dir(neocode_directory, config_path.as_path()) {
                Ok(()) => println!("{}", "Symlink done ------------------- \n \n".blue().bold()),
                Err(err) => println!("Error Symlink: {}", err),
            }
        }

        // run_packer_install();
    }

    pub fn get_home_dir() -> PathBuf {
        let os = env::consts::OS;
        let mut config_folder_path = PathBuf::from("");

        if os == "windows" {
            // set URL for windows config
            match env::var("USERPROFILE") {
                Ok(val) => {
                    config_folder_path.push(val);
                }
                Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
            }
            return config_folder_path;
        } else if os == "linux" {
            // set URL for unix config
            match env::var("HOME") {
                Ok(val) => {
                    config_folder_path.push(val);
                }
                Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
            }
            return config_folder_path;
        } else if os == "macos" {
            // set URL for unix config
            match env::var("HOME") {
                Ok(val) => {
                    config_folder_path.push(val);
                }
                Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
            }
            return config_folder_path;
        } else {
            println!("Something is wrong!");
            // this is a terrible way to handle errors
            // TODO:
            return PathBuf::from("");
        }
    }

    pub fn check_for_binary(binary_name: &str) -> bool {
        use which::which;
        println!("Checking if {} is installed", binary_name);
        let is_installed: bool;
        match which(binary_name) {
            Ok(location) => {
                println!(
                    "{} is installed! Located at: {}",
                    binary_name,
                    location.display()
                );
                is_installed = true;
                return is_installed;
            }
            Err(_err) => {
                println!(
                    "Uh oh! Looks like {} is not installed. Let's mark it for installation...",
                    binary_name
                );
                is_installed = false;
                return is_installed;
            }
        }
    }

    pub fn copy_dir_all(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> io::Result<()> {
        fs::create_dir_all(&dst)?;
        for entry in fs::read_dir(src)? {
            let entry = entry?;
            let ty = entry.file_type()?;
            if ty.is_dir() {
                copy_dir_all(entry.path(), dst.as_ref().join(entry.file_name()))?;
            } else {
                fs::copy(entry.path(), dst.as_ref().join(entry.file_name()))?;
            }
        }
        Ok(())
    }

    pub fn create_usercustom(custom_path: PathBuf) {
        let mut config_dir = custom_path.clone();
        config_dir.push("../lua/user");
        let mut template_dir = custom_path.clone();
        template_dir.push("user-template");
        env::set_current_dir(custom_path).unwrap();

        match copy_dir_all(template_dir.as_path(), config_dir.as_path()) {
            Ok(()) => println!(
                "{}",
                "Copied user template into config directory!".blue().bold()
            ),
            Err(err) => println!(
                "{} {}",
                "Couldn't copy user template into config directory! \n "
                    .red()
                    .bold(),
                err
            ),
        }
    }
}

