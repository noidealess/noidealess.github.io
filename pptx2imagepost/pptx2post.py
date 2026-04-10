import os
import glob
import sys

try:
    import win32com.client
except ImportError:
    print("请先安装 pywin32 库：pip install pywin32")
    sys.exit(1)

def convert_pptx_to_nodeppt():
    # 获取当前 Python 脚本所在的目录
    current_dir = os.path.dirname(os.path.abspath(__file__))
    
    # 自动识别同目录下的所有 pptx 文件
    ppt_files = glob.glob(os.path.join(current_dir, "*.pptx"))
    
    # 过滤掉 Office 产生的临时文件（以 ~$ 开头）
    ppt_files = [f for f in ppt_files if not os.path.basename(f).startswith("~$")]

    if not ppt_files:
        print("当前目录下未找到任何 .pptx 文件。")
        return

    print("正在启动 PowerPoint 应用...")
    try:
        # 使用 DispatchEx 确保启动独立的进程，有时比 Dispatch 更稳定
        powerpoint = win32com.client.Dispatch("PowerPoint.Application")
    except Exception as e:
        print(f"启动 PowerPoint 失败，请确保电脑已安装 Microsoft Office。错误信息: {e}")
        return

    for ppt_path in ppt_files:
        filename = os.path.basename(ppt_path)
        base_name = os.path.splitext(filename)[0]
        
        export_folder = os.path.join(current_dir, base_name)
        md_file_path = os.path.join(current_dir, f"{base_name}.md")
        
        if not os.path.exists(export_folder):
            os.makedirs(export_folder)
            
        print(f"\n正在处理: {filename} (分辨率: 2560x1440) ...")
        
        try:
            # 后台静默打开 PPT
            presentation = powerpoint.Presentations.Open(ppt_path, True, False, False)
            slide_count = presentation.Slides.Count
            
            with open(md_file_path, 'w', encoding='utf-8') as md_file:
                md_file.write("---\n")
                md_file.write(f"title: {base_name}\n")
                md_file.write("theme: default\n")
                md_file.write("---\n\n")
                
                for i in range(1, slide_count + 1):
                    slide = presentation.Slides(i)
                    image_name = f"{i}.png"
                    # 这里是关键：ScaleWidth=2560, ScaleHeight=1440
                    image_path = os.path.join(export_folder, image_name)
                    
                    # slide.Export(FileName, FilterName, ScaleWidth, ScaleHeight)
                    slide.Export(image_path, "PNG", 2560, 1440)
                    
                    md_file.write(f"![]({base_name}/{image_name})\n\n")
                    
            presentation.Close()
            print(f"处理完成！图片已存至 {base_name} 文件夹。")
            
        except Exception as e:
            print(f"处理 {filename} 时发生错误: {e}")

    powerpoint.Quit()

if __name__ == "__main__":
    convert_pptx_to_nodeppt()
