pub mod funcs {
    use predicates::prelude::*;
    use std::env;
    use std::fs;
    use std::path::Path;
    use std::path::PathBuf;
    use Result::Err;
    use Result::Ok;

    #[cfg(target_os = "windows")]
    use std::os::windows::fs::symlink_dir;

    #[cfg(target_family = "unix")]
    use std::os::unix::fs::symlink as symlink_dir;

    pub fn backup_old_config(config_path: PathBuf) {
        println!("Backing up old config directory ------------------");
        println!("Current OS is {}", env::consts::OS); // Prints the current OS.

        // Change process directory to the systems config folder
        match env::set_current_dir(config_path.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_path.display()),
            Err(err) => println!("Error: {}", err),
        }

        // Rename the nvim folder to nvim.old (backup)
        println!("Trying to rename nvim folder...");
        match fs::rename("nvim", "nvim.old") {
            Ok(()) => {
                println!("Old config back up complete")
            }
            Err(_) => {
                println!("You don't have an old config to back up. Skipping...")
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
        // Backup complete. CD back to starting directory
        let os = env::consts::OS;
        match env::set_current_dir(starting_dir.as_path()) {
            Ok(()) => println!("Back to starting directory"),
            Err(err) => println!("Error: {}", err),
        }
        let dir: &Path = match starting_dir.parent() {
            Some(val) => val,
            None => Path::new(""),
        };
        // the starting dir's parent is where the dotfiles are.
        println!("The starting dir parent is: {}", dir.display());

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
                Ok(()) => println!("Symlink done -------------------"),
                Err(err) => println!("Error Symlink: {}", err),
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
                Ok(()) => println!("Symlink done -------------------"),
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
                Ok(()) => println!("Symlink done -------------------"),
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
    pub fn uninstall(){
        let mut data_dir: PathBuf = get_home_dir();
        let mut config_dir = get_home_dir();

        data_dir.push("AppData");
        data_dir.push("Local");
        data_dir.push("nvim-data");

        config_dir.push("AppData");
        config_dir.push("Local");
        config_dir.push("nvim");

        println!("data dir for windows: {}", data_dir.display());
        println!("config dir for windows: {}", config_dir.display());
        
        match fs::remove_dir(config_dir) {
            Ok(_) => println!("Deleted neovim folder"),
            Err(err) => println!("Err {}", err)
        }
        match fs::remove_dir_all(data_dir, ) {
            Ok(_) => println!("Deleted data folder"),
            Err(err) => println!("Err {}", err)
        }
    }

    #[cfg(target_family = "unix")]
    pub fn uninstall(){
        let mut data_dir: PathBuf = get_home_dir();
        let mut config_dir = get_home_dir();

        data_dir.push(".local");
        data_dir.push("share");
        data_dir.push("nvim");
        data_dir.push("site");
        data_dir.push("pack");
        data_dir.push("packer");

        config_dir.push(".config");
        // config_dir.push("nvim");

        println!("data dir for linux: {}", data_dir.display());
        println!("config dir for linux: {}", config_dir.display());

        match env::set_current_dir(config_dir.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_dir.display()),
            Err(err) => println!("Error: Couldn't change to config folder: {}", err),
        }

        match std::fs::remove_file("nvim") {
            Ok(_) => println!("Deleted config folder symlink"),
            Err(err) => println!("Err deleting symlink config: {}", err)
        }
        match fs::remove_dir_all(data_dir) {
            Ok(_) => println!("Deleted data folder"),
            Err(err) => println!("Err deleting data folder for packer: {}", err)
        }
    }


    #[cfg(target_os = "windows")]
    fn run_packer_install() {
        println!("starting packer for windows");
        std::process::Command::new("powershell")
            // .arg("-c")
            .arg("nvim")
            .arg("--headless")
            .arg("-c")
            .arg("'autocmd User PackerComplete quitall'")
            .arg("-c")
            .arg("'PackerSync'")
            // .arg("+PackerInstall")
            .spawn()
            .expect("Error: Failed to run editor")
            .wait()
            .expect("Error: Editor returned a non-zero status");
    }

    #[cfg(target_family = "unix")]
    fn run_packer_install() {
        println!("starting packer for linux or macos");
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
}
