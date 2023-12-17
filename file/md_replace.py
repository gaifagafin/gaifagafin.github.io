import os
import argparse

def replace_in_file(file_path, replacements):
    """
    替换单个文件中的多个内容

    Args:
        file_path (str): 要替换内容的文件路径
        replacements (list): 包含要替换的内容和替换后的内容的元组列表
    """
    try:
        # 读取文件内容
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()

        # 遍历替换列表，逐一替换内容
        for old_text, new_text in replacements:
            content = content.replace(old_text, new_text)

        # 将替换后的内容写回文件
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(content)

        print(f'{file_path} 替换成功')
    except Exception as e:
        print(f'{file_path} 替换失败: {e}')

def replace_in_files(file_paths, replacements):
    """
    批量替换多个文件中的多个内容

    Args:
        file_paths (list): 包含要替换内容的文件路径列表
        replacements (list): 包含要替换的内容和替换后的内容的元组列表
    """
    for file_path in file_paths:
        replace_in_file(file_path, replacements)

def main():
    # 创建命令行解析器
    parser = argparse.ArgumentParser(description='批量替换Markdown文件中的内容')
    parser.add_argument('-f', '--folder', default=os.getcwd(), help='Markdown文件夹路径，默认为当前工作目录')
    parser.add_argument('--file', help='要替换内容的单个文件相对路径')
    args = parser.parse_args()

    folder_path = args.folder
    file_path = args.file

    # 检查文件夹是否存在
    if not os.path.exists(folder_path) or not os.path.isdir(folder_path):
        print(f'文件夹不存在: {folder_path}')
        return

    # 获取文件夹下所有Markdown文件
    if file_path:
        # 如果提供了--file参数，只替换指定文件
        file_path = os.path.join(folder_path, file_path)  # 将相对路径转换为绝对路径
        if not os.path.exists(file_path) or not os.path.isfile(file_path):
            print(f'指定文件不存在: {file_path}')
            return
        file_paths = [file_path]
    else:
        # 否则替换整个文件夹下的所有文件
        file_paths = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.lower().endswith('.md')]

    if not file_paths:
        print(f'文件夹中没有Markdown文件')
        return

    # 提示用户输入要替换的内容和替换后的内容，输入空行表示输入结束
    replacements = []
    while True:
        old_text = input('请输入要替换的内容（输入空行结束）: ')
        if not old_text:
            break
        new_text = input('请输入替换后的内容: ')
        replacements.append((old_text, new_text))

    # 调用替换函数
    replace_in_files(file_paths, replacements)

if __name__ == "__main__":
    main()
