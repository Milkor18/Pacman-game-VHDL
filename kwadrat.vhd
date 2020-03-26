library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity kwadrat is 
port(
clk : in std_logic;
x : in integer range 0 to 1023;
y : in integer range 0 to 1023;
rgb : out std_logic_vector(7 downto 0);
ruch : in std_logic_vector(3 downto 0));
end kwadrat;

architecture Behavioral of kwadrat is
signal bok : integer := 13;
signal pozycjakwadratuX : integer := 40;
signal pozycjakwadratuY : integer := 40;
begin

Ruchkwadratu : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if (x = 640) and (y = 480) then
	
		if (ruch = "0111") then
			if ((pozycjakwadratuY + bok) <= 2) then
				pozycjakwadratuY <= (479 + bok);
			else 
			pozycjakwadratuY <= (pozycjakwadratuY - 3);
			end if;
		elsif (ruch = "1011") then
			if ((pozycjakwadratuX - bok) >= 639) then
				pozycjakwadratuX <= (0 - bok);
			else 
			pozycjakwadratuX <= (pozycjakwadratuX + 3);
			end if;
		elsif (ruch = "1101") then
			if ((pozycjakwadratuY - bok) >= 479) then
				pozycjakwadratuY <= (0 - bok);
			else 
			pozycjakwadratuY <= (pozycjakwadratuY + 3);
			end if;
		elsif (ruch = "1110") then
			if ((pozycjakwadratuX + bok) <= 2) then
				pozycjakwadratuX <= (639 + bok);
			else 
			pozycjakwadratuX <= (pozycjakwadratuX - 3);
			end if;
		end if;
		
	end if;
end if;
	
end process;

Wyswietlanie : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if (x < 640) and (y < 480) then
		
		if ((((x - pozycjakwadratuX) * (x - pozycjakwadratuX)) +((y - pozycjakwadratuY) * (y - pozycjakwadratuY))) < (bok * bok)) then
			rgb <= "11111100";
				if (( y < (x + pozycjakwadratuY - pozycjakwadratuX)) and ( y > ((-1 * x) + pozycjakwadratuY + pozycjakwadratuX))) then
					rgb <= "00000000";
				end if;	
			--		if (( x = (pozycjakwadratuX + (bok / 2)))  and ( y = (pozycjakwadratuY + (bok / 2))) ) then
			--			red <= "000";
			--			green <= "000";
			--			blue <= "00";
			--			end if;
			
		else
			rgb <= "00000000";
		end if;
	else
		rgb <= "00000000";

	end if;
end if;
end process;

end Behavioral;