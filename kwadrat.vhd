library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity kwadrat is 
port(
clk : in std_logic;
x : in integer;
y : in integer;
rgb : out std_logic_vector(7 downto 0);
ruch : in std_logic_vector(3 downto 0));
end kwadrat;

architecture Behavioral of kwadrat is
signal bokA : integer := 20;
signal bokB : integer := 20;
constant bokjedzenia : integer := 10;
--signal los : integer := 0;
signal pozycjakwadratuX : integer := 40;
signal pozycjakwadratuY : integer := 40;
signal pozycjajedzeniaX : integer := 80;
signal pozycjajedzeniaY : integer := 80;
signal pozycjawrogaX : integer := 400;
signal pozycjawrogaY : integer := 400;
begin

Kwadrat : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if (x = 640) and (y = 480) then
	
		if (ruch = "0111") then
			if (pozycjakwadratuY <= 2) then
				pozycjakwadratuY <= (478 + bokB);
			else 
			pozycjakwadratuY <= (pozycjakwadratuY - 4);
			end if;
		elsif (ruch = "1011") then
			if (pozycjakwadratuX >= 638) then
				pozycjakwadratuX <= (0 - bokA);
			else 
			pozycjakwadratuX <= (pozycjakwadratuX + 4);
			end if;
		elsif (ruch = "1101") then
			if ((pozycjakwadratuY - bokB) >= 478) then
				pozycjakwadratuY <= 0;
			else 
			pozycjakwadratuY <= (pozycjakwadratuY + 4);
			end if;
		elsif (ruch = "1110") then
			if ((pozycjakwadratuX + bokA) <= 2) then
				pozycjakwadratuX <= 638;
			else 
			pozycjakwadratuX <= (pozycjakwadratuX - 4);
			end if;
		end if;
		
	end if;
end if;
end process;

Jedzenie : process (clk) is
begin 
if rising_edge(clk) then
	if ((pozycjakwadratuX + bokA) > pozycjajedzeniaX) and (pozycjakwadratuX < (pozycjajedzeniaX + bokjedzenia)) and (pozycjakwadratuY > (pozycjajedzeniaY - bokjedzenia)) and ((pozycjakwadratuY - bokB) < pozycjajedzeniaY) then
	--if ((pozycjakwadratuX + bokA) > pozycjajedzeniaX) and ((pozycjakwadratuX - bokA) < (pozycjajedzeniaX + bokjedzenia)) and ((pozycjakwadratuY + bokB) > (pozycjajedzeniaY - bokjedzenia)) and ((pozycjakwadratuY - bokB) < pozycjajedzeniaY) then
		bokA <= bokA + 10;
		if(pozycjajedzeniaY < 590) then
		pozycjajedzeniaX <= pozycjajedzeniaX + 50;
		end if;
		if(pozycjajedzeniaY < 400) then
		pozycjajedzeniaY <= pozycjajedzeniaY + 70;
		end if;
	end if;
end if;
end process;

Duch : process (clk) is
begin 
if rising_edge(clk) then

	if (x = 640) and (y = 480) then
		if ( pozycjawrogaX < pozycjakwadratuX) then
			pozycjawrogaX <= pozycjawrogaX + 1;
		else 
			pozycjawrogaX <= pozycjawrogaX - 1;
		end if;
		if ( pozycjawrogaY < pozycjakwadratuY) then
			pozycjawrogaY <= pozycjawrogaY + 1;
		else 
			pozycjawrogaY <= pozycjawrogaY - 1;
		end if;
	end if;
end if;
end process;


Wyswietlanie : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if (x < 640) and (y < 480) then
		
		if (x < (pozycjakwadratuX + bokA)) and (x > pozycjakwadratuX) and (y > (pozycjakwadratuY - bokB)) and (y < pozycjakwadratuY) then
			rgb <= "11111100";
		--if ((((x - pozycjakwadratuX) * (x - pozycjakwadratuX)) +((y - pozycjakwadratuY) * (y - pozycjakwadratuY))) < 169) then
		--	rgb <= "11111100";
				--if (( y < (x + pozycjakwadratuY - pozycjakwadratuX)) and ( y > ((-1 * x) + pozycjakwadratuY + pozycjakwadratuX))) then
					--rgb <= "00000000";
				--end if;	
		elsif (x < (pozycjajedzeniaX + bokjedzenia)) and (x > pozycjajedzeniaX) and (y > (pozycjajedzeniaY - bokjedzenia)) and (y < pozycjajedzeniaY) then
			rgb <= "11001111";
		elsif (x < (pozycjawrogaX + bokB)) and (x > pozycjawrogaX) and (y > (pozycjawrogaY - bokB)) and (y < pozycjawrogaY) then
			rgb <= "11001111";
		else
			rgb <= "00000000";
		end if;
	else
		rgb <= "00000000";

	end if;
end if;
end process;

end Behavioral;