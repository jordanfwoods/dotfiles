component example_entity is
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
end component example_entity;
