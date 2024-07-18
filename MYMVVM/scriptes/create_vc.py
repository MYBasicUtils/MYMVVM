from datetime import datetime
import os
import my_file

def create_vc_h(prefix,module_name):
    print(f"正在生成${module_name}h文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_h_content = ""
    ds_h_content += "//\n" 
    ds_h_content += "//  "+prefix+""+module_name+"ViewController.h\n" 
    ds_h_content += "//\n" 
    ds_h_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_h_content += "//\n" 
    ds_h_content += "\n" 
    ds_h_content += "#import <MYMVVM/MYMVVM.h>\n" 
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_BEGIN\n" 
    ds_h_content += "\n" 
    ds_h_content += "@interface "+prefix+""+module_name+"ViewController : MYTableViewController\n" 
    ds_h_content += "\n" 
    ds_h_content += "@end\n"
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_END\n" 
    ds_h_content += "\n" 
    print(ds_h_content)
    return ds_h_content


def create_vc_m(prefix,module_name):
    print(f"正在生成${module_name}m文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_m_content = ""
    ds_m_content += "//\n" 
    ds_m_content += "//  "+prefix+""+module_name+"ViewController.h\n" 
    ds_m_content += "//\n" 
    ds_m_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_m_content += "//\n" 
    ds_m_content += "\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"ViewController.h\"\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"DataSource.h\"\n" 
    ds_m_content += "\n" 
    ds_m_content += "@interface "+prefix+""+module_name+"ViewController ()\n" 
    ds_m_content += "\n" 
    ds_m_content += "@property (nonatomic, strong) "+prefix+module_name+"DataSource *dataSource;\n" 
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    ds_m_content += "@implementation "+prefix+""+module_name+"ViewController\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (void)viewDidLoad {\n" 
    ds_m_content += "\t[super viewDidLoad];\n" 
    ds_m_content += "\t[self initView];\n" 
    ds_m_content += "\t[self initData];\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (void)initView {\n" 
    ds_m_content += "\tself.title = @\""+module_name+"\";\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (void)initData {\n" 
    ds_m_content += "\tself.tableViewDelegate.dataSource = self.dataSource;\n" 
    ds_m_content += "\t[self.dataSource request];\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "- ("+prefix+module_name+"DataSource *)dataSource {\n" 
    ds_m_content += "\tif (!_dataSource) {\n" 
    ds_m_content += "\t\t_dataSource = [["+prefix+module_name+"DataSource alloc] init];\n" 
    ds_m_content += "\t}\n" 
    ds_m_content += "\treturn _dataSource;\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    print(ds_m_content)
    return ds_m_content

def create_vc(prefix,module_name,file_path):
    create_h_content = create_vc_h(prefix,module_name)
    ds_h_file = prefix+module_name+"ViewController.h"
    file_h_path = os.path.join(file_path,ds_h_file)
    my_file.writeStrToFile(create_h_content,file_h_path)

    create_m_cotenet = create_vc_m(prefix,module_name)
    ds_m_file = prefix+module_name+"ViewController.m"
    file_m_path = os.path.join(file_path,ds_m_file)
    my_file.writeStrToFile(create_m_cotenet,file_m_path)

