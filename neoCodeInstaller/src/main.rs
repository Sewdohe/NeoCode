use clap::Parser;
use std::env;
use std::path::PathBuf;
use Result::Err;
use Result::Ok;
mod helpers;
use colored::*;
pub use helpers::funcs;

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
}

fn main() {
    let args = Args::parse();
    let uninstall = args.uninstall;
    let install_packer = args.install_packer;
    let testing = args.testing;

    let starting_dir: PathBuf = match env::current_dir() {
        Ok(val) => val,
        Err(_err) => PathBuf::new(),
    };

    if uninstall {
        funcs::uninstall();
        println!("Config uninstalled.");
        return;
    } else {
        if !testing {
            funcs::check_dependencies();
            
            let config_folder_path = funcs::determine_config_path();
            funcs::backup_old_config(config_folder_path.clone());
            funcs::symlink_config(config_folder_path.clone(), starting_dir);
            if install_packer {
                funcs::run_packer_install();
            } else {
                println!("{}", "SKIPPING STEP 3: --install_packer flag wasn't passed. Automatic packer install skipped.".blue().bold());
            }
        }
    }
}
