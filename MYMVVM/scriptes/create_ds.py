from datetime import datetime
import os
import my_file


def create_ds_h(prefix,module_name):
    print(f"正在生成${module_name}h文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_h_content = ""
    ds_h_content += "//\n" 
    ds_h_content += "//  "+prefix+""+module_name+"DataSource.h\n" 
    ds_h_content += "//\n" 
    ds_h_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_h_content += "//\n" 
    ds_h_content += "\n" 
    ds_h_content += "#import <MYMVVM/MYMVVM.h>\n" 
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_BEGIN\n" 
    ds_h_content += "\n" 
    ds_h_content += "@interface "+prefix+""+module_name+"DataSource : MYDataSource\n" 
    ds_h_content += "\n" 
    ds_h_content += "@end\n"
    ds_h_content += "\n" 
    ds_h_content += "NS_ASSUME_NONNULL_END\n" 
    ds_h_content += "\n" 
    print(ds_h_content)
    return ds_h_content


def create_ds_m(prefix,module_name):
    print(f"正在生成${module_name}m文件")
    now = datetime.now()
    formatted_now = now.strftime("%Y/%m/%d")
    ds_m_content = ""
    ds_m_content += "//\n" 
    ds_m_content += "//  "+prefix+""+module_name+"DataSource.h\n" 
    ds_m_content += "//\n" 
    ds_m_content += "//  Created by APPLE on " + formatted_now+".\n"
    ds_m_content += "//\n" 
    ds_m_content += "\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"DataSource.h\"\n" 
    ds_m_content += "#import \""+prefix+""+module_name+"ViewModel.h\"\n" 
    ds_m_content += "\n" 
    ds_m_content += "@interface "+prefix+""+module_name+"DataSource ()\n" 
    ds_m_content += "\n" 
    ds_m_content += "@property (nonatomic, strong) MYSectionModel *sectionModel;\n" 
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    ds_m_content += "@implementation "+prefix+""+module_name+"DataSource\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (instancetype)init\n" 
    ds_m_content += "{\n" 
    ds_m_content += "\tself = [super init];\n" 
    ds_m_content += "\tif (self) {\n" 
    ds_m_content += "\tself.sectionModels = @[self.sectionModel];\n" 
    ds_m_content += "\n" 
    ds_m_content += "\t}\n" 
    ds_m_content += "\treturn self;\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (void)request {\n" 
    ds_m_content += "\t"+prefix+""+module_name+"ViewModel *vm = [["+prefix+module_name+"ViewModel alloc] init];\n" 
    ds_m_content += "\tself.sectionModel.viewModels = @[vm];\n" 
    ds_m_content += "\tif (self.successBlock) {\n" 
    ds_m_content += "\t\tself.successBlock();\n" 
    ds_m_content += "\t}\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "- (MYSectionModel *)sectionModel {\n" 
    ds_m_content += "\tif (!_sectionModel) {\n" 
    ds_m_content += "\t\t_sectionModel = [[MYSectionModel alloc] init];\n" 
    ds_m_content += "\t}\n" 
    ds_m_content += "\treturn _sectionModel;\n" 
    ds_m_content += "}\n" 
    ds_m_content += "\n" 
    ds_m_content += "@end\n" 
    ds_m_content += "\n" 
    return ds_m_content

def create_ds(prefix,module_name,file_path):
    create_h_content = create_ds_h(prefix,module_name)
    ds_h_file = prefix+module_name+"DataSource.h"
    file_h_path = os.path.join(file_path,ds_h_file)
    my_file.writeStrToFile(create_h_content,file_h_path)

    create_m_cotenet = create_ds_m(prefix,module_name)
    ds_m_file = prefix+module_name+"DataSource.m"
    file_m_path = os.path.join(file_path,ds_m_file)
    my_file.writeStrToFile(create_m_cotenet,file_m_path)

