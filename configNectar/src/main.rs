use std::env;
use std::path::PathBuf;
use Result::Ok;
use Result::Err;


mod helpers;

pub  use helpers::funcs;

fn main() {
    let starting_dir: PathBuf = match env::current_dir() {
        Ok(val) => val,
        Err(_err) => PathBuf::new()
    };
    let mut config_folder_path = PathBuf::from("");
 


    config_folder_path = funcs::determine_config_path();
    funcs::backup_old_config(config_folder_path.clone());
    funcs::symlink_config(config_folder_path.clone(), starting_dir);

}

