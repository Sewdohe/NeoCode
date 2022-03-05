pub mod scripts {
    use colored::*;
    use crate::helpers::funcs;

    pub fn install_neovim() {
        use std::process::Stdio;

        let mut scoop_path = funcs::get_home_dir();
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
}
