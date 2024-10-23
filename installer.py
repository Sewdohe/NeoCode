import os
import platform
import subprocess
import sys

from colorama import init as colorama_init
from colorama import Fore
from colorama import Style

SYSTEM_NAME = ""

colorama_init()

def link(uri, label=None):
    """Formats a link using the given label
    for console usage"""
    if label is None: 
        label = uri
    parameters = ''

    # OSC 8 ; params ; URI ST <name> OSC 8 ;; ST 
    escape_mask = '\033]8;{};{}\033\\{}\033]8;;\033\\'

    return escape_mask.format(parameters, uri, label)

def get_nvim_config_dir():
    """Returns the Neovim config directory path for a auto-detected operating system"""
    home = os.path.expanduser("~")
    if platform.system() == "Windows":
        print(f"{Fore.WHITE} - Determined config location should be at {os.path.join(home, "AppData","Local", "nvim")}")
        return os.path.join(home, "AppData", "Local", "nvim")
    else:
        print(f"{Fore.WHITE} - Determined config location should be at {os.path.join(home, ".config", "nvim")}")
        return os.path.join(home, ".config", "nvim")

def create_symlink(source, dest):
    """Creates a symlink between the configuration location and
    Neovims config directory for a given Operating system."""
    try:
        if os.path.exists(dest):
            if os.path.islink(dest) or os.path.isfile(dest):
                os.remove(dest)
            elif os.path.isdir(dest):
                os.rmdir(dest)
        os.symlink(source, dest)
    except OSError as e:
        print(f"Failed to create symlink {dest}: {e}")

def install_config():
    """Creates the symlink from whereever you run the installer from to the
    Neocode config directory for the given system."""
    print(f"{Fore.WHITE}---{Fore.CYAN} Symlinking NeoCode to config directory {Fore.WHITE}---")
    config_dir = get_nvim_config_dir()
    source_dir = os.path.join(os.path.dirname(__file__), 'nvim-config')

    if not os.path.exists(config_dir):
        print(f"{Fore.WHITE} - Nvim config directory doesn't exist...creating for you")
        os.makedirs(config_dir)
    elif os.path.exists(config_dir):
        print(f"{Fore.LIGHTRED_EX} - Existing Neovim config folder detected. Renaming folder to nvim.backup")
        os.rename(config_dir, "nvim.backup")

    for item in os.listdir(source_dir):
        s = os.path.join(source_dir, item)
        d = os.path.join(config_dir, item)
        try:
            create_symlink(s, d)
        except:
            print(f"{Fore.RED}An error occured during the symlink! Please vist the Discord for support.")
            return None

    print(f"{Fore.LIGHTBLUE_EX} SYMLINK SUCCESSFUL! \n {Fore.WHITE}")

def determine_package_manager():
    """Returns the package manager name for the given system, to be used by
    the install_dependencies function"""
    print(f" {Fore.WHITE}--- {Fore.CYAN}Picking package manager based on OS {Fore.WHITE}---")
    system_info = platform.freedesktop_os_release()
    system_name = system_info.get('ID')
    print(f" {Fore.WHITE}--- {Fore.CYAN}System is {Fore.WHITE}---" + system_name)
    SYSTEM_NAME = system_name

    if system_name == 'fedora':
        print(" - system is Fedora! Use DNF. \n")
        return "dnf"
    if system_name == 'ubuntu':
        print(" - system is Ubuntu! Use apt. \n")
        return "apt"
    if system_name == 'darwin':
        print(" - system is MacOS! Use brew. \n")
        return "brew"
    if system_name == 'endeavouros':
        print(" - system is Endeavour! Use pacman. \n")
        return "pacman"
    if system_name == 'manjaro':
        print(" - system is Manjaro! Use pacman. \n")
        return "pacman"


def check_and_install_choco():
    """Installs Choco for Windows users without it."""
    try:
        subprocess.check_call(["choco", "--version"])
    except subprocess.CalledProcessError:
        print("- Chocolatey is not installed. Installing Chocolatey...")
        subprocess.check_call(['powershell', '-Command', 'Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString(\'https://chocolatey.org/install.ps1\'))'])

def check_and_install_brew():
    """Installs Brew for MacOS users who don't have it installed."""
    try:
        subprocess.check_call(["brew", "--version"])
    except subprocess.CalledProcessError:
        print("- Homebrew is not installed. Installing Homebrew...")
        subprocess.check_call(['/bin/bash', '-c', "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"])

## TODO: Lazygit requires special commands to install for each OS. Will have to add those.

def install_dependencies():
    """Uses the package manager returned from determine_package_manager() to install
    things the users needs to have in order to run Neocode."""
    # Determine the package manger we should use
    # based off the users OS
    package_manager = determine_package_manager()
    dependencies = [
        "ripgrep",
        "fzf",
        "lazygit",
        "fortune-mod"
    ]

    # Print header for this step
    # and set the fore color for all console output for dep checks
    print(f" {Fore.WHITE}--- {Fore.CYAN}Check and install dependencies {Fore.WHITE}---{Fore.MAGENTA}")
    print

    # Install pip if not already installed
    try:
        import pip
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "ensurepip", "--upgrade"])
    
    if platform.system() != "Linux":
        # Install Python packages for Neovim
        subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pynvim"])

    # Ensure the package manager function returned SOMETHING
    if package_manager:
        # Install Neovim itself
        if platform.system() == "Linux":
            if package_manager == "apt":
                subprocess.check_call(["sudo", package_manager, "install", "neovim"])
                for dep in dependencies:
                    subprocess.check_call(["sudo", package_manager, "install", "-y", dep])
            elif package_manager == "pacman":
                # subprocess.check_call(["sudo", package_manager, "-S", "neovim"])
                for dep in dependencies:
                    subprocess.check_call(["sudo", package_manager, "-S", dep, "--noconfirm"])
        elif platform.system() == "Darwin":
            check_and_install_brew()
            for dep in dependencies:
                subprocess.check_call(["sudo", package_manager, "install", "-y", dep])
            subprocess.check_call(["sudo", package_manager, "install", "-y", "neovim"])
        elif platform.system() == "Windows":
            check_and_install_choco()
            for dep in dependencies:
                subprocess.check_call(["sudo", package_manager, "install", dep])
            subprocess.check_call(["choco", "install", "neovim"])
        else:
            print("idk what even is your OS.")
    # Handle the package manager function returning nothing/getting confused.
    else:
        print("Sorry...I couldn't determine your operating system to install NeoCode.")

def run_packer_install():
    """headlessly installs packer plugins for Neovim so first boot will be smooth"""
    print(f" {Fore.WHITE}--- {Fore.CYAN}Run Packer install for clean first-startup {Fore.WHITE}---{Fore.MAGENTA}")
    command = ["nvim", "--headless", "-c", "autocmd User PackerComplete quitall", "-c", "PackerSync"]
    subprocess.check_call(command)

if __name__ == "__main__":
    # try:
    print(f"{Fore.WHITE}--- {Fore.GREEN} NeoCode Installer {Fore.WHITE}---")
    print(f"{Fore.BLUE} Thanks for trying NeoCode!")
    print(f"{Fore.WHITE} Visit the {Fore.MAGENTA}{link("https://discord.gg/9tZq3WrU4p", "Discord")}{Fore.WHITE} for support. \n")
    install_config()
    install_dependencies()
    run_packer_install()
    print(f"{Fore.LIGHTBLUE_EX}Neovim configuration installed successfully!")
    # except:
    #     print(f"{Fore.RED}An error occured during the install process! Sorry d00d!")
