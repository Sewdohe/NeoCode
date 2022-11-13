use clap::Parser;
use std::env;
use std::path::PathBuf;
use Result::Err;
use Result::Ok;
mod helpers;
use colored::*;
pub use helpers::standard_helpers;

#[cfg(target_os = "windows")]
pub mod win;
#[cfg(target_os = "windows")]
pub use win::helpers_windows as OSFuncs;

#[cfg(target_os = "linux")]
pub mod linux;
#[cfg(target_os = "linux")]
pub use linux::helpers_linux as OSFuncs;

#[cfg(target_os = "macos")]
pub mod osx;
#[cfg(target_os = "macos")]
pub use osx::helpers_osx as OSFuncs;

#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Name of the person to greet
    #[clap(short, long)]
    uninstall: bool,

    #[clap(short, long)]
    install_packer: bool,

    #[clap(short, long)]
    testing: bool,

    #[clap(short, long)]
    deps: bool,

    #[clap(short, long)]
    create_user: bool,
}

fn main() {
    let args = Args::parse();
    let uninstall = args.uninstall;
    let install_packer = args.install_packer;
    let deps = args.deps;
    let create_user = args.create_user;

    let mut starting_dir: PathBuf = match env::current_exe() {
        Ok(val) => val.parent().unwrap().to_path_buf(),
        Err(_err) => PathBuf::new(),
    };

    if uninstall {
        OSFuncs::uninstall();
        println!("Config uninstalled.");
    } else {
        let config_folder_path = standard_helpers::determine_config_path();

        if deps {
            // install deps if the user so wishes
            OSFuncs::check_dependencies();
        }

        // go ahead and clone the config
        standard_helpers::clone_config_repo();

        if create_user {
            // if this flag is passed, create the custom user directory
            standard_helpers::create_usercustom(starting_dir.clone());
        }
        // backup the old config (if there is one)
        standard_helpers::backup_old_config(config_folder_path.clone());
        standard_helpers::pause();
        // symlink the new config (this one)
        standard_helpers::symlink_config(config_folder_path, &mut starting_dir);
        standard_helpers::pause();
        // headlessly run packer sync if the user wants it
        if install_packer {
            OSFuncs::run_packer_install();
        } else {
            println!("{}", "SKIPPING STEP 3: --install_packer flag wasn't passed. Automatic packer install skipped.".blue().bold());
            println!(
                "{}",
                "You'll have to run :PackerInstall to download plugins!!"
                    .red()
                    .bold()
            );
            standard_helpers::pause();
        }
    }
}
