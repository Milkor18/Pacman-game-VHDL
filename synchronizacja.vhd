library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity synchronizacja is 
port(
clk : in std_logic;
ruch : in std_logic_vector(3 downto 0);
hsync : out std_logic;
vsync : out std_logic;
red : out std_logic_vector(2 downto 0);
green : out std_logic_vector(2 downto 0);
blue : out std_logic_vector(2 downto 1)
);	
end synchronizacja;

architecture Behavioral of synchronizacja is

signal x : integer;
signal y : integer;
signal rgb : std_logic_vector(7 downto 0);
begin

synchronizacja: process (clk) is
begin
if rising_edge(clk) then

	if (y >= 490) and (y < 492) then
		vsync <= '0';
	else
		vsync <= '1';
	end if;

	if (x >= 656) and (x < 752) then
		hsync <= '0';
	else
		hsync <= '1';
	end if;
	
	if (x = 799) then
		x <= 0;
		if (y = 525) then
			y <= 0;
		else
			y <= y + 1;
		end if;
	else
		x <= x + 1;
	end if;


end if;	
end process;

wezkwadrat: entity kwadrat port map (clk => clk, x => x, y => y, rgb => rgb, ruch => ruch);
red <= rgb(7 downto 5);
green <= rgb(4 downto 2);
blue <= rgb(1 downto 0);


end Behavioral;