library verilog;
use verilog.vl_types.all;
entity ROM_trans_new is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        LZDout          : in     vl_logic_vector(6 downto 0);
        segment         : out    vl_logic_vector(6 downto 0)
    );
end ROM_trans_new;
