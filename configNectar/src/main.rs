use std::fs;
use std::env;
use std::path::PathBuf;
use std::path::Path;
use Result::Ok;
use Result::Err;
use predicates::prelude::*;

#[cfg(target_os = "windows")]
use std::os::windows::fs::symlink_dir;

#[cfg(target_family = "unix")]
use std::os::unix::fs::symlink as symlink_dir;



fn main() {
    let starting_dir: PathBuf = match env::current_dir() {
        Ok(val) => val,
        Err(_err) => PathBuf::new()
    };
    let mut config_folder_path = PathBuf::from("");
    let os = env::consts::OS;
 

    if os == "windows" {
        // set URL for windows config
        match env::var("USERPROFILE") {
            Ok(val) => {
                config_folder_path.push(val);
            },
            Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
        }
        config_folder_path.push("AppData");
        config_folder_path.push("Local");
    } else if os == "linux" {
         // set URL for unix config
         match env::var("HOME") {
            Ok(val) => {
                config_folder_path.push(val);
            },
            Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
        }
        config_folder_path.push(".config");
    } else if os == "macos" {
        // set URL for unix config
        match env::var("HOME") {
            Ok(val) => {
                config_folder_path.push(val);
            },
            Err(e) => println!("couldn't interpret {}: {}", "USERPROFILE", e),
        }
        config_folder_path.push(".config");
    }

    backup_old_config(config_folder_path.clone());
    symlink_config(config_folder_path.clone(), starting_dir);
    // install_packer();

}


fn backup_old_config(config_path: PathBuf) {

    println!("Backing up old config directory ------------------");
    println!("Current OS is {}", env::consts::OS); // Prints the current OS.

        // Change process directory to the systems config folder
        match env::set_current_dir(config_path.as_path()) {
            Ok(()) => println!("Changed dir to config: {}", config_path.display()),
            Err(err) => println!("Error: {}", err)
        }
        
        // Rename the nvim folder to nvim.old (backup)
        println!("Trying to rename nvim folder...");
        match fs::rename("nvim", "nvim.old" ) {
            Ok(()) => {println!("Old config back up complete")},
            Err(err) => { println!("Error: {}", err)}
        }
    }

fn symlink_config(mut config_path: PathBuf, starting_dir: PathBuf) {
    // Backup complete. CD back to starting directory
    let os = env::consts::OS;
    match env::set_current_dir(starting_dir.as_path()) {
        Ok(()) => println!("Back to starting directory"),
        Err(err) => println!("Error: {}", err)
    }
    let dir: &Path = match starting_dir.parent(){
        Some(val) => val,
        None => Path::new("")
    };
    // the starting dir's parent is where the dotfiles are.
    println!("The starting dir parent is: {}", dir.display());

    config_path.push("nvim");

    // Symlink the config directory now
    if os == "windows" {
        println!("trying to [windows] symlink {} to {}", dir.display(), config_path.display());

        // TODO: Check if symlink exists already
        // assert that the nvim directory isn't already a symlink
        let predicate_fn = predicate::path::is_symlink();
        assert_eq!(false, predicate_fn.eval(config_path.as_path()), "Looks like your nvim directory is already symlinked!");

        match symlink_dir(dir, config_path.as_path()){
            Ok(()) => println!("Symlink done -------------------"),
            Err(err) => println!("Error Symlink: {}", err)
        }
    } else if os == "linux" {
        println!("trying to [unix] symlink {} to {}", dir.display(), config_path.display());

        // assert that the nvim directory isn't already a symlink
        let predicate_fn = predicate::path::is_symlink();
        assert_eq!(false, predicate_fn.eval(config_path.as_path()), "Looks like your nvim directory is already symlinked!");

        match symlink_dir(dir, config_path.as_path()){
            Ok(()) => println!("Symlink done -------------------"),
            Err(err) => println!("Error Symlink: {}", err)
        }
    } else if os == "macos" {
        println!("trying to [macOS] symlink {} to {}", dir.display(), config_path.display());

        // assert that the nvim directory isn't already a symlink
        let predicate_fn = predicate::path::is_symlink();
        assert_eq!(false, predicate_fn.eval(config_path.as_path()), "Looks like your nvim directory is already symlinked!");

        match symlink_dir(dir, config_path.as_path()){
            Ok(()) => println!("Symlink done -------------------"),
            Err(err) => println!("Error Symlink: {}", err)
        }
    }

    run_packer_install();
}

#[cfg(target_os = "windows")]
fn run_packer_install() {
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
    std::process::Command::new("sh")
    .arg("-c")
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
