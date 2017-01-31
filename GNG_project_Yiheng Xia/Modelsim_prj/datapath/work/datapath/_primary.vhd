library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dataa           : in     vl_logic_vector(14 downto 0);
        segment         : in     vl_logic_vector(6 downto 0);
        result          : out    vl_logic_vector(15 downto 0);
        done            : out    vl_logic
    );
end datapath;
