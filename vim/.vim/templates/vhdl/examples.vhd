-- e:package start --
package example_package is
   procedure print(active: boolean);
   type ABC is (A, B, C);
end example_package;
-- e:package end --

-- e:package body start --
package body example_package is
   procedure print(active: boolean) is
   begin
      if active then
         -- do something
      end if;
   end print;
end example_package;
-- e:package body end --

-- e:entity start --
entity example_entity is
   generic (
      ASI_DATA_WIDTH          : integer := 32;        -- width of ASI input data
      ASI_CHAN_WIDTH          : integer := 9          -- width of ASI input channels
   );
   port (
      -- Inputs
      your_input0               : in std_logic;
      your_input1               : in std_logic_vector(7 downto 0);
      -- Outputs
      your_output0              : out std_logic;
      your_output1              : out std_logic_vector(7 downto 0);
      -- Inouts
      your_inout0               : inout std_logic;
      your_inout1               : inout std_logic_vector(7 downto 0)
      -- Linkage
      your_linkage0             : linkage std_logic;
      your_linkage1             : linkage std_logic_vector(7 downto 0)
      -- Buffer
      your_buffer0              : buffer std_logic;
      your_buffer1              : buffer std_logic_vector(7 downto 0)
    );
end entity example_entity;
-- e:entity end --

-- e:architecture start --
architecture rtl of example_entity is
   -- Put your signal/type declarations here
   signal output : std_logic;
   variable v_cnt : integer;
begin
   -- Put your assignments here
   your_output0 <= your_input0;
   your_output1 <= your_input1;

   -- Put your instantiations here

   -- Put your processes here
end rtl;
-- e:architecture end --

-- e:function start --
function bypass(inp: std_logic) return std_logic is
begin
   return inp;
end bypass;
-- e:function end --

-- e:procedure start --
procedure bypass2(inp: in std_logic; outp: inout std_logic)is
begin
  outp <= inp;
end bypass2;
-- e:procedure end --

-- e:if start --
if expr1 then
   counter <= 0;
elsif expr2 then
   counter <= 1;
else
   counter <= 2;
endif;
-- e:if end --

-- e:case start --
case counter is
   when 0 => {sequential statement}
   when 1 => {sequential statement}
   when others => null;
end case;
-- e:case end --

-- e:while start --
while expr loop
   {sequential statement}
end loop;
-- e:while end --

-- e:for start --
for ID in range loop
    {sequential statement}
end loop;
-- e:for end --

-- e:assign start --
out1 <= in1 or in2;
out2 <= in1 nor in2;
out3 <= in1 and in2;
out4 <= in1 nand in2;
out5 <= in1 xor in2;
out6 <= in1 xnor in2;
out7 <= not in1;
-- e:assign end --

-- e:block start --
b_example : block
begin
   q <= d when a = '1' else '0';
end block;
-- e:block end --

-- e:process start --
p_register : process(clock)
begin
   if rising_edge(clock) then
      q <= d;
   end if;
end process;
-- e:process end --
