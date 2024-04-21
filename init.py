#!python3
import subprocess


def run_shell_script(script_path):
    try:
        # Execute the script
        result = subprocess.run([script_path], check=True, text=True, capture_output=True)
        # Print output and return code
        print("STDOUT:", result.stdout)
        print("STDERR:", result.stderr)
    except subprocess.CalledProcessError as e:
        # Handle errors in the called shell script
        print("Error:", e)
        print("Return Code:", e.returncode)
        print("Output:", e.output)

if __name__ == "__main__":
    script_path = './stow.sh'  # Update with your actual script path
    run_shell_script(script_path)
