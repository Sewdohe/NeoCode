use std::fs;
use std::env;
use std::path::PathBuf;
use std::path::Path;
use Result::Ok;
use Result::Err;

#[cfg(target_os = "windows")]
use std::os::windows::fs::symlink_dir;

#[cfg(target_os = "unix")]
use std::os::unix::fs::symlink_dir;

fn main() {
    println!("Backing up old config directory");
    println!("Current OS is {}", env::consts::OS); // Prints the current OS.
    let os = env::consts::OS;
    let starting_dir: PathBuf = match env::current_dir() {
        Ok(val) => val,
        Err(err) => PathBuf::new()
    };
    let mut config_path = PathBuf::from("");

    if os == "windows" {
        // set URL for windows config
        match env::var("USERPROFILE") {
            Ok(val) => {
                config_path.push(val);
            },
            Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
        }
        config_path.push("AppData");
        config_path.push("Local");

        // Change directory to the local appdata folder
        match env::set_current_dir(config_path.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_path.display()),
            Err(err) => println!("Error: {}", err)
        }
        
        println!("Trying to rename nvim folder...");
        // Rename the nvim folder to nvim.old (backup)
        match fs::rename("nvim", "nvim.old" ) {
            Ok(()) => {println!("Old config back up complete")},
            Err(err) => { println!("Error: {}", err)}
        }
    } else if os == "unix" {
        // set URL for windows config
        match env::var("HOME") {
            Ok(val) => {
                config_path.push(val);
            },
            Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
        }
        config_path.push(".config");

        // Change directory to the local appdata folder
        match env::set_current_dir(config_path.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_path.display()),
            Err(err) => println!("Error: {}", err)
        }
        
        println!("Trying to rename nvim folder...");
        // Rename the nvim folder to nvim.old (backup)
        match fs::rename("nvim", "nvim.old" ) {
            Ok(()) => {println!("Old config back up complete")},
            Err(err) => { println!("Error: {}", err)}
        }
    }

    // Backup complete. CD back to starting directory
    match env::set_current_dir(starting_dir.as_path()) {
        Ok(()) => println!("Back to starting directory"),
        Err(err) => println!("Error: {}", err)
    }
    let dir: &Path = match starting_dir.parent(){
        Some(val) => val,
        None => Path::new("")
    };
    println!("The starting dir parent is: {}", dir.display());

    config_path.push("nvim");

    // Symlink the config directory now
    if os == "windows" {
        println!("trying to [windows] symlink {} to {}", dir.display(), config_path.display());
        match symlink_dir(dir, config_path.as_path()){
            Ok(()) => println!("Symlink done"),
            Err(err) => println!("Error Symlink: {}", err)
        }
    } else if os == "unix" {
        println!("trying to [unix] symlink {} to {}", dir.display(), config_path.display());
        match symlink_dir(dir, config_path.as_path()){
            Ok(()) => println!("Symlink done"),
            Err(err) => println!("Error Symlink: {}", err)
        }
    }
}
