import create_ds
import create_vc
import create_iv
import create_vm
import os

def main():
     # TODO: wmy test
     # prefix = input("输入想要生成的前缀名称(prefix):")
     # module_name = input("输入想要生成的模块名称(moduleName):")
     prefix = "MY"
     module_name = "VedioHome"
     print(module_name)
      
     directory = os.getcwd() + "/product/"
     print("当前路径为"+directory)
     if not os.path.exists(directory):
        os.makedirs(directory)
        print(f"目录 '{directory}' 已创建。")

     create_ds.create_ds(prefix,module_name,directory)
     create_vc.create_vc(prefix,module_name,directory)
     create_iv.create_iv(prefix,module_name,directory)
     create_vm.create_vm(prefix,module_name,directory)

main()