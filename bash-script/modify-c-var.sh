# 将条件写入数组
conditions=("a[3] > 3" "b[5] > 50" "c[4] < -2.4" "d[5] > 2.4")

# 遍历数组中的条件
for i in "${!conditions[@]}"; do
  # 取出当前条件
  condition="${conditions[$i]}"
  # 使用正则表达式分离变量名和比较符号后面的数字
  if [[ "$condition" =~ ^(.*)\s+([<>]=?)\s+([-+]?[0-9]*\.?[0-9]+)$ ]]; then
    # 取出变量名
    var="${BASH_REMATCH[1]}"
    # 取出比较符号
    op="${BASH_REMATCH[2]}"
    # 取出数字
    num="${BASH_REMATCH[3]}"
    # 修改变量的值
    sed -i "s/\($var $op\) *[0-9]*\.?[0-9]*/\1$num/" file.c
  fi
done
第9行解释：
if：条件语句的开头。
[[ ]]：用于测试条件表达式的结构，类似于 [ ]。
"$condition"：需要检查的变量名。
=~：模式匹配操作符，用于匹配一个正则表达式。
^：正则表达式的开始符号。
(.*)：匹配任意字符零个或多个，用小括号括起来，表示一个分组。
\s+：匹配一个或多个空格字符。
([<>]=?)：匹配 "<", ">", "<=" 或 ">="，用小括号括起来，表示一个分组。
\s+：同上。
([-+]?[0-9]*.?[0-9]+)：匹配一个数字，可以包含正负号、小数点等，用小括号括起来，表示一个分组。
$：正则表达式的结束符号。
]]：条件表达式的结束符号。
这段代码的作用是匹配 $condition 是否符合指定的格式，如果符合，则执行 if 后面的语句块。具体来说，这个正则表达式匹配的是类似于 "x >= 10" 这样的字符串，
其中 x 是变量名，10 是数字，而且 x 可以是任意字符。如果匹配成功，$BASH_REMATCH 数组就会保存匹配结果。
