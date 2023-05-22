source ./config.cfg

echo "export PATH=${setup_path}/code:\$PATH" >> ~/.bashrc

#将code文件夹中的py脚本的编译器更改$PYTHON_PATH
cd code
for i in *.py; do
    sed -i 's/PYTHON_PATH/#!\/${PYTHON_PATH}/g' *.txt
done