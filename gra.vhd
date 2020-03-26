library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gra is
port(
       clk : in std_logic;
		 ruch : in std_logic_vector(3 downto 0);
       hsync : out std_logic;
       vsync : out std_logic;
       red : out std_logic_vector(2 downto 0);
       green : out std_logic_vector(2 downto 0);
       blue : out std_logic_vector(2 downto 1));       
end gra;

architecture Behavioral of gra is

component czestotliwosc is
  port ( CLKIN_IN        : in    std_logic; 
         CLKFX_OUT       : out   std_logic);
end component;

signal clk25mhz : std_logic;
begin   

pixel_clock : czestotliwosc port map (CLKIN_IN => clk, CLKFX_OUT => clk25mhz);
display : entity synchronizacja port map (clk => clk25mhz, hsync => hsync, vsync => vsync,                                                                                        
               red => red, green => green, blue => blue, ruch => ruch);

end Behavioral;