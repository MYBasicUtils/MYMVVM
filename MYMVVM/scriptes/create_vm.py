from datetime import datetime
import os
import my_file

def create_vm_h(prefix,module_name):
    print(f"正在生成${module_name}h文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_h_content = ""
    ds_h_content += "//\n" 
    ds_h_content += "//  "+prefix+""+module_name+"ViewModel.h\n" 
    ds_h_content += "//\n" 
    ds_h_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_h_content += "//\n" 
    ds_h_content += "\n" 
    ds_h_content += "#import <MYMVVM/MYMVVM.h>\n" 
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_BEGIN\n" 
    ds_h_content += "\n" 
    ds_h_content += "@interface "+prefix+""+module_name+"ViewModel : MYViewModel\n" 
    ds_h_content += "\n" 
    ds_h_content += "@end\n"
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_END\n" 
    ds_h_content += "\n" 
    print(ds_h_content)
    return ds_h_content


def create_vm_m(prefix,module_name):
    print(f"正在生成${module_name}m文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_m_content = ""
    ds_m_content += "//\n" 
    ds_m_content += "//  "+prefix+""+module_name+"ViewModel.h\n" 
    ds_m_content += "//\n" 
    ds_m_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_m_content += "//\n" 
    ds_m_content += "\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"ViewModel.h\"\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"ItemView.h\"\n" 
    ds_m_content += "\n" 
    ds_m_content += "@interface "+prefix+""+module_name+"ViewModel ()\n" 
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    ds_m_content += "@implementation "+prefix+""+module_name+"ViewModel\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (CGSize)itemSize {\n" 
    ds_m_content += "\treturn CGSizeMake(MY_ScreenWidth(), 100);\n" 
    ds_m_content += "}\n"
    ds_m_content += "\n" 
    ds_m_content += "- (Class)itemViewClass {\n"  
    ds_m_content += "\treturn "+prefix+module_name+"ItemView.class;\n" 
    ds_m_content += "}\n"
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    print(ds_m_content)
    return ds_m_content

def create_vm(prefix,module_name,file_path):
    create_h_content = create_vm_h(prefix,module_name)
    ds_h_file = prefix+module_name+"ViewModel.h"
    file_h_path = os.path.join(file_path,ds_h_file)
    my_file.writeStrToFile(create_h_content,file_h_path)

    create_m_cotenet = create_vm_m(prefix,module_name)
    ds_m_file = prefix+module_name+"ViewModel.m"
    file_m_path = os.path.join(file_path,ds_m_file)
    my_file.writeStrToFile(create_m_cotenet,file_m_path)

