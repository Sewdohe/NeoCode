use std::fs;
use std::env;
use std::os::windows::fs::symlink_dir;
use std::path::PathBuf;
use std::path::Path;
// use std::os::windows::fs::symlink_dir;
use Result::Ok;
use Result::Err;

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
            Ok(()) => println!("Changed dir to config"),
            Err(err) => println!("Error: {}", err)
        }
               
        // Rename the nvim folder to nvim.old (backup)
        match fs::rename("nvim", "nvim.old" ) {
            Ok(()) => {println!("Old config back up complete")},
            Err(err) => { println!("Error: {}", err)}
        }
    } else if os == "unix" {

    }

    // Backup complete. CD back to starting directory
    match env::set_current_dir(starting_dir.as_path()) {
        Ok(()) => println!("Back to starting directory"),
        Err(err) => println!("Error: {}", err)
    }
    let mut dir: &Path = match starting_dir.parent(){
        Some(val) => val,
        None => Path::new("")
    };
    println!("The starting dir is: {}", dir.display());

    // Symlink the config directory now
    match symlink_dir(dir, config_path.as_path()){
        Ok(()) => println!("Symlink done"),
        Err(err) => println!("Error {}", err)
    }
}
