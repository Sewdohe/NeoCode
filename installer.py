import os
import platform
import subprocess
import sys
import shutil

try:
    from colorama import init as colorama_init
    from colorama import Fore, Style
    colorama_init()
    _COLORAMA_AVAILABLE = True
except ImportError:
    _COLORAMA_AVAILABLE = False
    class _NoColor:
        WHITE = CYAN = GREEN = BLUE = MAGENTA = LIGHTRED_EX = LIGHTBLUE_EX = RED = ''
    class _NoStyle:
        RESET_ALL = ''
    Fore = _NoColor
    Style = _NoStyle

SYSTEM_NAME = ""

def is_termux():
    """Detects if running in Termux environment on Android"""
    # Check for Termux-specific environment variables and paths
    return (os.environ.get('PREFIX', '').startswith('/data/data/com.termux') or
            os.path.exists('/data/data/com.termux'))

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
        nvim_path = os.path.join(home, "AppData", "Local", "nvim")
        print(f"{Fore.WHITE} - Determined config location should be at {nvim_path}")
        return nvim_path
    else:
        nvim_path = os.path.join(home, ".config", "nvim")
        print(f"{Fore.WHITE} - Determined config location should be at {nvim_path}")
        return nvim_path

def create_symlink(source, dest):
    """Creates a symlink between the configuration location and
    Neovims config directory for a given Operating system."""
    try:
        if not os.path.exists(source):
            print(f"{Fore.LIGHTRED_EX} - Source does not exist, skipping: {source}")
            return

        parent = os.path.dirname(dest)
        if parent and not os.path.exists(parent):
            os.makedirs(parent, exist_ok=True)

        if os.path.exists(dest):
            if os.path.islink(dest) or os.path.isfile(dest):
                os.remove(dest)
            elif os.path.isdir(dest):
                shutil.rmtree(dest)

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
        parent_dir = os.path.dirname(config_dir)
        backup_base = os.path.join(parent_dir, 'nvim.backup')
        backup_candidate = backup_base
        idx = 1
        while os.path.exists(backup_candidate):
            backup_candidate = f"{backup_base}.{idx}"
            idx += 1

        print(f"{Fore.LIGHTRED_EX} - Existing Neovim config folder detected. Renaming folder to {backup_candidate}")
        try:
            shutil.move(config_dir, backup_candidate)
        except OSError as e:
            print(f"{Fore.RED}Failed to rename existing config directory: {e}")
            return None

        # Recreate the now-empty config directory so we can populate it
        try:
            os.makedirs(config_dir, exist_ok=True)
        except OSError as e:
            print(f"{Fore.RED}Failed to create new config directory {config_dir}: {e}")
            return None

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

    # Check for Termux first before checking freedesktop_os_release
    if is_termux():
        print(f" {Fore.WHITE}--- {Fore.CYAN}System is {Fore.WHITE}---Termux (Android)")
        print(" - system is Termux! Use pkg. \n")
        return "pkg"

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
    if system_name == 'arch':
        print(" - system is Arch! Use pacman. \n")
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
    # Map package names -> representative executable or check name.
    # If the executable exists on PATH we will skip installing the package.
    dependencies = {
        "ripgrep": "rg",
        "fzf": "fzf",
        "lazygit": "lazygit",
        "fortune-mod": "fortune",
    }

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
        try:
            import importlib.util
            if importlib.util.find_spec('pynvim') is None:
                subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pynvim"])
        except Exception:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pynvim"])

    # Ensure the package manager function returned SOMETHING
    if package_manager:
        # Install Neovim itself and only install missing dependencies
        if is_termux():
            # Termux (Android) - uses pkg without sudo
            missing = []
            for pkg, exe in dependencies.items():
                if shutil.which(exe) is None:
                    missing.append(pkg)

            # Install neovim if `nvim` is not available
            if shutil.which('nvim') is None:
                subprocess.check_call(["pkg", "install", "-y", "neovim"])

            # Install missing dependencies
            if missing:
                for dep in missing:
                    subprocess.check_call(["pkg", "install", "-y", dep])
        elif platform.system() == "Linux":
            # Only install what's missing. Check executables first.
            missing = []
            for pkg, exe in dependencies.items():
                if shutil.which(exe) is None:
                    missing.append(pkg)

            # Install neovim if `nvim` is not available
            if shutil.which('nvim') is None:
                if package_manager == "apt":
                    subprocess.check_call(["sudo", package_manager, "install", "-y", "neovim"])
                elif package_manager == "pacman":
                    subprocess.check_call(["sudo", package_manager, "-S", "neovim", "--noconfirm"])
                elif package_manager == "dnf":
                    subprocess.check_call(["sudo", package_manager, "install", "-y", "neovim"])

            if missing:
                if package_manager == "apt":
                    for dep in missing:
                        subprocess.check_call(["sudo", package_manager, "install", "-y", dep])
                elif package_manager == "pacman":
                    for dep in missing:
                        subprocess.check_call(["sudo", package_manager, "-S", dep, "--noconfirm"])
                elif package_manager == "dnf":
                    for dep in missing:
                        subprocess.check_call(["sudo", package_manager, "install", "-y", dep])
        elif platform.system() == "Darwin":
            check_and_install_brew()
            missing = []
            for pkg, exe in dependencies.items():
                if shutil.which(exe) is None:
                    missing.append(pkg)
            if missing:
                for dep in missing:
                    subprocess.check_call(["sudo", package_manager, "install", "-y", dep])
            if shutil.which('nvim') is None:
                subprocess.check_call(["sudo", package_manager, "install", "-y", "neovim"])
        elif platform.system() == "Windows":
            check_and_install_choco()
            missing = []
            for pkg, exe in dependencies.items():
                if shutil.which(exe) is None:
                    missing.append(pkg)
            if missing:
                for dep in missing:
                    subprocess.check_call([package_manager, "install", dep])
            if shutil.which('nvim') is None:
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
    try:
        subprocess.check_call(command)
    except FileNotFoundError:
        print(f"{Fore.RED}Neovim not found in PATH. Please install Neovim and re-run this step.")
    except subprocess.CalledProcessError as e:
        print(f"{Fore.RED}Packer sync failed or packer.nvim is not installed: {e}")
        print(f"{Fore.WHITE}Try opening Neovim and run `:PackerSync` manually, or install packer.nvim first.")

if __name__ == "__main__":
    # try:
    print(f"{Fore.WHITE}--- {Fore.GREEN} NeoCode Installer {Fore.WHITE}---")
    print(f"{Fore.BLUE} Thanks for trying NeoCode!")
    # print(f"{Fore.WHITE} Visit the {Fore.MAGENTA}{link("https://discord.gg/9tZq3WrU4p", "Discord")}{Fore.WHITE} for support. \n")
    install_config()
    install_dependencies()
    run_packer_install()
    print(f"{Fore.LIGHTBLUE_EX}Neovim configuration installed successfully!")
    # except:
    #     print(f"{Fore.RED}An error occured during the install process! Sorry d00d!")
