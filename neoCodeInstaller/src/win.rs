pub mod helpers_windows {
  use colored::*;
  use std::fs;
  use std::path::PathBuf;
  use crate::standard_helpers::*;

  #[cfg(target_os = "windows")]
  pub fn clone_config_repo() {
      let repo_url = "https://github.com/Sewdohe/NeoCode";
      std::process::Command::new("powershell")
          .arg("git")
          .arg("clone")
          .arg(repo_url)
          .spawn()
          .expect("Error: couldn't clone repo")
          .wait()
          .expect("Error: please try again");
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

  #[cfg(target_os = "windows")]
  pub fn install_neovim() {
      use std::process::Stdio;

      let mut scoop_path = crate::standard_helpers::get_home_dir();
      scoop_path.push("scoop");
      scoop_path.push("shims");

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
          println!(
              "{} {}",
              "Error during neovim install: \n \n"
                  .blue()
                  .bold()
                  .underline(),
              output_string.red()
          );
          // nvim_installed = false;
      } else {
          // nvim_installed = true;
      }
  }

  // Check for dependencies for windows
  #[cfg(target_os = "windows")]
  pub fn check_dependencies() {
      use core::panic;
      use std::process::Stdio;
      
      let mut scoop_path = get_home_dir();
      scoop_path.push("scoop");
      scoop_path.push("shims");

      let mut scoop_installed = check_for_binary("scoop");
      let mut nvim_installed = check_for_binary("nvim");
      let mut gcc_installed = check_for_binary("gcc");
      let mut make_installed = check_for_binary("make");
      let mut ripgrep_installed = check_for_binary("rg");
      let mut fzf_installed = check_for_binary("fzf");
      let mut lazygit_installed = check_for_binary("lazygit");

      if !scoop_installed {
          // iwr -useb get.scoop.sh | iex
          std::process::Command::new("powershell")
              .args(["iwr", "-useb", "get.scoop.sh", "| iex"])
              .spawn()
              .expect("Error: Failed to run scoop installer")
              .wait()
              .expect("Failed to run scoop install");

          //install scoop's git, we need it to use buckets
          // the regular git doesn't seem to do the job
          std::process::Command::new("powershell")
              .env("PATH", &scoop_path)
              .args(["scoop", "install", "git"])
              .spawn()
              .expect("Error: Failed to install git")
              .wait()
              .expect("Git install failed");

          let mut git_path = scoop_path.clone();
          git_path.push("apps");
          git_path.push("git");
          git_path.push("current");

          println!("Attemping bucket addition...");
          // we need the versions bucket in order to install neovim
          std::process::Command::new("scoop")
              .env("PATH", scoop_path.as_os_str())
              .env("PATH", git_path)
              .args(["bucket", "add", "versions"])
              .spawn()
              .expect("Error: Failed to add versions bucket")
              .wait()
              .expect("Version bucket failed");

          // add extras bucket to get lazygit
          std::process::Command::new("scoop")
              .env("PATH", scoop_path.as_os_str())
              .args(["bucket", "add", "extras"])
              .spawn()
              .expect("Error: Failed to add extras bucket")
              .wait()
              .expect("Extras bucket failed");

          println!("{}", "Scoop install completed successfully".blue());
          scoop_installed = true;
      }

      if scoop_installed {
          // a bit nasty and redundant...but adding code for buckets here as well since it
          // appears bucket installs may fail on first install of scoop
          // we need the versions bucket in order to install neovim
          std::process::Command::new("scoop")
              .env("PATH", scoop_path.as_os_str())
              .arg("bucket")
              .arg("add")
              .arg("versions")
              .spawn()
              .expect("Error: failed to add versions bucket")
              .wait()
              .expect("Error: Something went wrong");

          std::process::Command::new("scoop")
              .env("PATH", scoop_path.as_os_str())
              .arg("bucket")
              .arg("add")
              .arg("extras")
              .spawn()
              .expect("Error: failed to add versions bucket")
              .wait()
              .expect("Error: Something went wrong");

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

          if !fzf_installed {
              std::process::Command::new("powershell")
                  .env("PATH", scoop_path.as_os_str())
                  .arg("scoop")
                  .arg("install")
                  .arg("fzf")
                  .spawn()
                  .expect("Error: Failed to install gcc")
                  .wait()
                  .expect("Error: Something went wrong");

              fzf_installed = true;
          }

          if !ripgrep_installed {
              std::process::Command::new("powershell")
                  .env("PATH", scoop_path.as_os_str())
                  .arg("scoop")
                  .arg("install")
                  .arg("ripgrep")
                  .spawn()
                  .expect("Error: Failed to install gcc")
                  .wait()
                  .expect("Error: Something went wrong");

              ripgrep_installed = true;
          }

          if !lazygit_installed {
              std::process::Command::new("powershell")
                  .env("PATH", scoop_path.as_os_str())
                  .arg("scoop")
                  .arg("install")
                  .arg("lazygit")
                  .spawn()
                  .expect("Error: Failed to install gcc")
                  .wait()
                  .expect("Error: Something went wrong");

              lazygit_installed = true;
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
              // install neovim-nightly from the versions bucket
              let nvim_installer = std::process::Command::new("powershell")
                  .env("PATH", scoop_path.as_os_str())
                  .env("NEOVIDE_MULTIGRID", "") // set multigrid in case the user uses Neovide
                  .arg("scoop")
                  .arg("install")
                  .arg("neovim")
                  .stdout(Stdio::piped())
                  .spawn()
                  .expect("Error: Failed to install neovim")
                  .wait_with_output()
                  .expect("Error: Something went wrong");

              // store output, convert to a string, and check for "ERROR"
              let output = nvim_installer.stdout;
              let output_string = String::from_utf8(output).unwrap();
              if output_string.contains("ERROR") {
                  println!(
                      "{} {}",
                      "Error during neovim install: \n \n"
                          .blue()
                          .bold()
                          .underline(),
                      output_string.red()
                  );
                  nvim_installed = false;
              } else {
                  // No error, install was good
                  println!("{}", "Neovim install completed".blue().bold());
                  nvim_installed = true;
              }
          }
      }

      if scoop_installed
          && make_installed
          && gcc_installed
          && nvim_installed
          && ripgrep_installed
          && fzf_installed
          && lazygit_installed
      {
          println!("{}", "All deps. are met! Time to configure...".blue());
      } else {
          panic!("All deps didn't install! ABORT!!");
      }
  }
}