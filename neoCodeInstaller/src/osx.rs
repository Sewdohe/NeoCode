pub mod helpers_osx {
  use crate::standard_helpers::get_home_dir;
  use colored::Colorize;
  use std::env;
  use std::fs;
  use std::path::PathBuf;

  #[cfg(target_family = "macos")]
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

      match env::set_current_dir(config_dir.as_path()) {
          Ok(()) => println!("Changed dir to config: {}", config_dir.display()),
          Err(err) => println!("Error: Couldn't change to config folder: {}", err),
      }

      match std::fs::remove_file("nvim") {
          Ok(_) => println!("Deleted config folder symlink"),
          Err(_err) => println!(
              "{}",
              "Err: No symlinked nvim config folder to remove"
                  .red()
                  .bold()
          ),
      }
      match fs::remove_dir_all(data_dir) {
          Ok(_) => println!("Deleted data folder"),
          Err(_err) => println!("{}", "Err: No data dir to delete".red().bold()),
      }
  }

  #[cfg(target_family = "macos")]
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
          .arg("--headless")
          .arg("-c")
          .arg("autocmd User PackerComplete quitall")
          .arg("-c")
          .arg("PackerSync")
          .spawn()
          .expect("Error: Failed to run editor")
          .wait()
          .expect("Error: Editor returned a non-zero status");
  }

  // Currently empty, allows compilation on macos.
  #[cfg(target_os = "macos")]
  pub fn check_dependencies() {
      // NOTE: Check if macOS dependencies are installed

      use core::panic;
      // use std::process::Stdio;
      // let mut bin_path = PathBuf::from(r"/usr/local/bin/");

      let mut brew_installed = check_for_binary("brew");
      let mut nvim_installed = check_for_binary("nvim");
      let mut fzf_installed = check_for_binary("fzf");
      let mut ripgrep_installed = check_for_binary("rg");
      // TODO: lazygit
      let mut lazygit_installed = check_for_binary("lazygit");

      if !brew_installed {
          std::process::Command::new("bash")
              .arg("-c")
              .arg("\"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
              .spawn()
              .expect("Error: failed to install Homebrew");
          brew_installed = true;
      }

      if brew_installed {
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
                  .arg("--cask")
                  .arg("--no-quarantine")
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
      }

      if brew_installed && nvim_installed && fzf_installed && ripgrep_installed {
          println!("{}", "All deps are met! Time to configure...".blue());
      } else {
          panic!("All deps didn't install! ABORT!");
      }
  }
}