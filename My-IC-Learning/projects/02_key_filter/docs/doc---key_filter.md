## 2026-10-11
### 1.模块代码与工程规范

✅ 编写中出现笔误，经检查发现问题

| 错误写法            | 正确写法          | 说明     |
| --------------- | ------------- | ------ |
| `20'd200_000 -` | `20'd200_000` | 多了一个减号 |
| `enmodule`      | `endmodule`   | 拼写错误   |
✅ 模块编写顺序整理
模块端口  （module / endmodule）
参数定义  （parameter）
内部信号  （reg / wire）
时序逻辑  （always @(posedge ...)）
组合逻辑  （assign / always @(*))

###  💡2.核心编写点
#### 1.reg 和 wire 的区别
reg：在 initial 或 always 块中被赋值的信号。

wire：用于连接模块输出，不能被 initial / always 赋值。

在 testbench 中：

sys_clk、sys_rst_n、key_in 是我们手动给的 → 用 reg
key_flag 是模块输出的 → 用 wire

#### 2.实例化模块（连线）

key_filter u_key_filter 
( .sys_clk (sys_clk), // 左边：模块端口名；右边：testbench 信号名 
.sys_rst_n (sys_rst_n),
.key_in (key_in),
.key_flag (key_flag) );

#### 3.复位与释放复位
sys_rst_n 的 n 表示 低电平有效（negative）
sys_rst_n = 0：复位中，模块内部寄存器清零
sys_rst_n = 1：复位释放，模块开始正常工作
复位 ≠ 按键反馈。复位是系统启动时的一次性初始化动作，按键反馈是后面 key_in 的变化。
