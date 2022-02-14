use std::env;
use std::path::PathBuf;
use Result::Ok;
use Result::Err;
use clap::Parser;

#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct Args {
    /// Name of the person to greet
    #[clap(short, long)]
    uninstall: bool,
}


mod helpers;

pub  use helpers::funcs;

fn main() {
    let args = Args::parse();
    let uninstall = args.uninstall;

    let starting_dir: PathBuf = match env::current_dir() {
        Ok(val) => val,
        Err(_err) => PathBuf::new()
    }; 

    if uninstall {
        funcs::uninstall();
        println!("Config uninstalled.");
        return;
    }

    let config_folder_path = funcs::determine_config_path(); 
    funcs::backup_old_config(config_folder_path.clone());
    funcs::symlink_config(config_folder_path.clone(), starting_dir);
    funcs::run_packer_install();

}

