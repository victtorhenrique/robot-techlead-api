from robot import run_cli
from utils.del_folders import delete_logs
import argparse

def get_env():
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", default="default")
    args = parser.parse_args()
    return args.env

if __name__ == '__main__':
   
    env = get_env()
    print(f"Ambiente selecionado: {env}")

    # Deletar a pasta de logs antes de iniciar a execução
    delete_logs()

    cli_args = ["-d", 
                "./logs", 
                "--variable", 
                f"ENV:{env}", 
                "."
    ]

    run_cli(cli_args)