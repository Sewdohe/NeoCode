pub mod funcs {
    use colored::*;
    use predicates::prelude::*;
    use std::env;
    use std::fs;
    use std::path::Path;
    use std::path::PathBuf;
    use Result::Err;
    use crate::installers::scripts;
    // use std::{thread, time};
    // use powershell_script;

    #[cfg(target_os = "windows")]
    use std::os::windows::fs::symlink_dir;

    #[cfg(target_family = "unix")]
    use std::os::unix::fs::symlink as symlink_dir;

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

    pub fn symlink_config(mut config_path: PathBuf, starting_dir: PathBuf) {
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
        let dir: &Path = match starting_dir.parent() {
            Some(val) => val,
            None => Path::new(""),
        };

        config_path.push("nvim");

        // Symlink the config directory now
        if os == "windows" {
            println!(
                "trying to [windows] symlink {} to {}",
                dir.display(),
                config_path.display()
            );

            // TODO: Check if symlink exists already
            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            match symlink_dir(dir, config_path.as_path()) {
                Ok(()) => println!("{}", "Symlink done ------------------- \n \n".blue().bold()),
                Err(err) => println!("{} {}", "Error Symlink: {}".red().bold(), err),
            }
        } else if os == "linux" {
            println!(
                "trying to [unix] symlink {} to {}",
                dir.display(),
                config_path.display()
            );

            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            match symlink_dir(dir, config_path.as_path()) {
                Ok(()) => println!("{}", "Symlink done ------------------- \n \n".red().bold()),
                Err(err) => println!("Error Symlink: {}", err),
            }
        } else if os == "macos" {
            println!(
                "trying to [macOS] symlink {} to {}",
                dir.display(),
                config_path.display()
            );

            // assert that the nvim directory isn't already a symlink
            let predicate_fn = predicate::path::is_symlink();
            assert_eq!(
                false,
                predicate_fn.eval(config_path.as_path()),
                "Looks like your nvim directory is already symlinked!"
            );

            match symlink_dir(dir, config_path.as_path()) {
                Ok(()) => println!("{}", "Symlink done ------------------- \n \n".red().bold()),
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

    #[cfg(target_os = "windows")]
    pub fn uninstall() {
        println!("{}", "Removing NeoCode configuration".blue().bold());
        let mut data_dir: PathBuf = get_home_dir();
        let mut config_dir = get_home_dir();

        data_dir.push("AppData");
        data_dir.push("Local");
        data_dir.push("nvim-data");

        config_dir.push("AppData");
        config_dir.push("Local");
        config_dir.push("nvim");

        // println!("data dir for windows: {}", data_dir.display());
        // println!("config dir for windows: {}", config_dir.display());

        match fs::remove_dir(config_dir) {
            Ok(_) => println!("Deleted config folder symlink"),
            Err(_) => println!(
                "{}",
                "Err: No symlinked nvim config folder to remove"
                    .red()
                    .bold()
            ),
        }
        match fs::remove_dir_all(data_dir) {
            Ok(_) => println!("Deleted data folder"),
            Err(_) => println!("{}", "Err: No data dir to delete".red().bold()),
        }
    }

    #[cfg(target_family = "unix")]
    pub fn uninstall() {
        println!("{}", "Removing NeoCode configuration".blue().bold());
        let mut data_dir: PathBuf = get_home_dir();
        let mut config_dir = get_home_dir();

        data_dir.push(".local");
        data_dir.push("share");
        data_dir.push("nvim");
        data_dir.push("site");
        data_dir.push("pack");
        data_dir.push("packer");

        config_dir.push(".config");

        // println!("data dir for linux: {}", data_dir.display());
        // println!("config dir for linux: {}", config_dir.display());

        match env::set_current_dir(config_dir.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_dir.display()),
            Err(err) => println!("Error: Couldn't change to config folder: {}", err),
        }

        match std::fs::remove_file("nvim") {
            Ok(_) => println!("Deleted config folder symlink"),
            Err(err) => println!(
                "{}",
                "Err: No symlinked nvim config folder to remove"
                    .red()
                    .bold()
            ),
        }
        match fs::remove_dir_all(data_dir) {
            Ok(_) => println!("Deleted data folder"),
            Err(err) => println!("{}", "Err: No data dir to delete".red().bold()),
        }
    }

    #[cfg(target_os = "windows")]
    pub fn run_packer_install() {
        println!(
            "{}",
            "STEP 3: running Neovim bootstrapping for windows"
                .blue()
                .bold()
        );

        let mut scoop_path = get_home_dir();
        scoop_path.push("scoop");
        scoop_path.push("shims");

        std::process::Command::new("powershell")
            .env("PATH", scoop_path.as_os_str())
            .arg("nvim")
            .arg("--headless")
            .arg("-c")
            .arg("'autocmd User PackerComplete quitall'")
            .arg("-c")
            .arg("'PackerSync'")
            .spawn()
            .expect("Error: Failed to run editor")
            .wait()
            .expect("Error: Editor returned a non-zero status");
    }

    #[cfg(target_family = "unix")]
    pub fn run_packer_install() {
        println!(
            "{}",
            "STEP 3: running Neovim bootstrapping for unix"
                .blue()
                .bold()
        );
        std::process::Command::new("sh")
            .arg("-c")
            .arg("nvim")
            .arg("-headless")
            .arg("-c")
            .arg("autocmd User PackerComplete quitall")
            .arg("-c")
            .arg("PackerSync")
            .spawn()
            .expect("Error: Failed to run editor")
            .wait()
            .expect("Error: Editor returned a non-zero status");
    }

    fn check_for_binary(binary_name: &str) -> bool {
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

    // Currently empty, allows compilation on macos.
    #[cfg(target_os = "macos")]
    pub fn check_dependencies() {
        // NOTE: Check if macOS dependencies are installed

        use core::panic;
        use std::process::Stdio;
        let mut bin_path = PathBuf::from(r"/usr/local/bin/");

        let mut nvim_installed = check_for_binary("nvim");
        let mut fzf_installed = check_for_binary("fzf");
        let mut ripgrep_installed = check_for_binary("rg");

        if !nvim_installed {
            //NOTE: Tap custom repo to get nightly builds
            std::process::Command::new("brew")
                .arg("tap")
                .arg("brukberhane/homebrew-brew")
                .spawn()
                .expect("Error: failed to tap 'brukberhane/brew'");

            std::process::Command::new("brew")
                .arg("install")
                .arg("neovim-nightly")
                .spawn()
                .expect("Error: failed to install neovim-nightly");
            nvim_installed = true;
        }

        if !fzf_installed {
            std::process::Command::new("brew")
                .arg("install")
                .arg("fzf")
                .spawn()
                .expect("Error: failed to install fzf");
            fzf_installed = true;
        }

        if !ripgrep_installed {
            std::process::Command::new("brew")
                .arg("install")
                .arg("ripgrep")
                .spawn()
                .expect("Error: failed to install ripgrep");
            ripgrep_installed = true;
        }

        if nvim_installed && fzf_installed && ripgrep_installed {
            println!("{}", "All deps are met! Time to configure...".blue());
        } else {
            panic!("All deps didn't install! ABORT!");
        }
    }

    // Check for dependencies for windows
    #[cfg(target_os = "windows")]
    pub fn check_dependencies() {
        // list of deps and if they are installed or not

        use core::panic;
        use std::process::Stdio;
        let mut scoop_path = get_home_dir();
        scoop_path.push("scoop");
        scoop_path.push("shims");

        let mut scoop_installed = check_for_binary("scoop");
        let mut nvim_installed = check_for_binary("nvim");
        let mut gcc_installed = check_for_binary("gcc");
        let mut make_installed = check_for_binary("make");

        if !scoop_installed {
            // iwr -useb get.scoop.sh | iex
            std::process::Command::new("powershell")
                .arg("iwr")
                .arg("-useb")
                .arg("get.scoop.sh")
                .arg("| iex")
                .spawn()
                .expect("Error: Failed to run scoop installer")
                .wait()
                .expect("Error: Something went wrong");

            //install scoop's git, we need it to use buckets
            // the regular git doesn't seem to do the job
            std::process::Command::new("powershell")
            .env("PATH", scoop_path.as_os_str())
            .arg("scoop")
            .arg("install")
            .arg("git")
            .spawn()
            .expect("Error: Failed to install git")
            .wait()
            .expect("Error: Something went wrong");

            std::process::Command::new("powershell")
                .env("PATH", scoop_path.as_os_str())
                .arg("scoop")
                .arg("bucket")
                .arg("add")
                .arg("versions")
                .spawn()
                .expect("Error: Failed to run scoop installer")
                .wait()
                .expect("Error: Something went wrong");

            println!("{}", "Scoop install completed successfully".blue());
            scoop_installed = true;

        }

        if scoop_installed {
            if !gcc_installed {
                std::process::Command::new("powershell")
                .env("PATH", scoop_path.as_os_str())
                .arg("scoop")
                .arg("install")
                .arg("gcc")
                .spawn()
                .expect("Error: Failed to install gcc")
                .wait()
                .expect("Error: Something went wrong");

                gcc_installed = true;
            }

            if !make_installed {
                std::process::Command::new("powershell")
                .env("PATH", scoop_path.as_os_str())
                .arg("scoop")
                .arg("install")
                .arg("make")
                .spawn()
                .expect("Error: Failed to install gcc")
                .wait()
                .expect("Error: Something went wrong");

                make_installed = true;
            }

            if !nvim_installed {
                let nvim_installer = std::process::Command::new("powershell")
                .env("PATH", scoop_path.as_os_str())
                .arg("scoop")
                .arg("install")
                .arg("neovim-nightly")
                .stdout(Stdio::piped())
                .spawn()
                .expect("Error: Failed to install neovim")
                .wait_with_output()
                .expect("Error: Something went wrong");
                

                let output = nvim_installer.stdout;
                

                let output_string = String::from_utf8(output).unwrap();

                

                //todo check output for error
                if output_string.contains("ERROR") {
                    println!("{} {}", "Error during neovim install: \n \n".blue().bold().underline(), output_string.red());
                    nvim_installed = false;
                } else {
                    println!("{}", "Neovim install completed".blue().bold());
                    nvim_installed = true;
                }
            }
        }
        
        if scoop_installed && make_installed && gcc_installed && nvim_installed {
            println!("{}", "All deps. are met! Time to configure...".blue());
        } else {
            panic!("All deps didn't install! ABORT!!");
        }
    }
}
