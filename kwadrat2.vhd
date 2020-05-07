library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity kwadrat is 
port(
clk : in std_logic;
x : in integer;
y : in integer;
rgb : out std_logic_vector(7 downto 0);
segment : out std_logic_vector(7 downto 0);
enable : out std_logic_vector(2 dowto 0);
ruch : in std_logic_vector(3 downto 0));
end kwadrat;

architecture Behavioral of kwadrat is

signal bokA : integer := 20;
--signal bokB : integer := 20;
constant bokjedzenia : integer := 10;
signal losX : integer := 400;
signal losY : integer := 200;
signal pozycjakwadratuX : integer := 40;
signal pozycjakwadratuY : integer := 40;
signal pozycjajedzeniaX : integer := 80;
signal pozycjajedzeniaY : integer := 80;
signal pozycjawrogaX : integer := 400;
signal pozycjawrogaY : integer := 400;
signal punkty : unsigned(3 downto 0) := (others => '0');
signal wynik : std_logic_vector(3 downto 0) := (others => '0');
signal przyspieszenie : integer := 0;
signal kolor : std_logic_vector(1 downto 0) := "00";
signal czasprzyspieszenia : unsigned(7 downto 0) := (others => '0'); 
signal przenies : std_logic := '0';
signal koniec : std_logic := '0';

begin

Kwadrat : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if(koniec = '0') then
		if (x = 640) and (y = 480) then
		
			if (ruch = "0111") then
				if (pozycjakwadratuY <= 2) then
					pozycjakwadratuY <= (478 + bokA);
				else 
				pozycjakwadratuY <= (pozycjakwadratuY - 4 - przyspieszenie);
				end if;
			elsif (ruch = "1011") then
				if (pozycjakwadratuX >= 638) then
					pozycjakwadratuX <= (0 - bokA);
				else 
				pozycjakwadratuX <= (pozycjakwadratuX + 4 + przyspieszenie);
				end if;
			elsif (ruch = "1101") then
				if ((pozycjakwadratuY - bokA) >= 478) then
					pozycjakwadratuY <= 0;
				else 
				pozycjakwadratuY <= (pozycjakwadratuY + 4 + przyspieszenie);
				end if;
			elsif (ruch = "1110") then
				if ((pozycjakwadratuX + bokA) <= 2) then
					pozycjakwadratuX <= 638;
				else 
					pozycjakwadratuX <= (pozycjakwadratuX - 4 - przyspieszenie);
				end if;
			end if;
		
		end if;
	else
		pozycjakwadratuX <= 40;
		pozycjakwadratuY <= 40;
	end if;	
end if;
end process;



--Losowanie : process (clk) is
--begin
--if rising_edge(clk) then
--	if (losX < 640) then
--		losX <= losX + 1;
--	else
--		losY <= losY + 1;
--		losX <= 0;
--	end if;
--	
--	if (losY = 480) then
--		losY <= 0;
--	end if;
--end if;
--end process;	



Jedzenie : process (clk) is
begin 
if rising_edge(clk) then

	if ((pozycjakwadratuX + bokA) > pozycjajedzeniaX) and (pozycjakwadratuX < (pozycjajedzeniaX + bokjedzenia)) and (pozycjakwadratuY > (pozycjajedzeniaY - bokjedzenia)) and ((pozycjakwadratuY - bokA) < pozycjajedzeniaY) then
	--if ((pozycjakwadratuX + bokA) > pozycjajedzeniaX) and ((pozycjakwadratuX - bokA) < (pozycjajedzeniaX + bokjedzenia)) and ((pozycjakwadratuY + bokA) > (pozycjajedzeniaY - bokjedzenia)) and ((pozycjakwadratuY - bokA) < pozycjajedzeniaY) then
		punkty <= punkty + 1;
		wynik <= std_logic_vector(punkty);
		if ( kolor = "01") then
			bokA <= bokA + 7;
		elsif ( kolor = "10") then
			przyspieszenie <= 8;
		else
			przenies <= '1';
		end if;
		pozycjajedzeniaX <= losX;
		pozycjajedzeniaY <= losY;
	end if;
	
	if (przyspieszenie = 8) or (przenies = '1') then
		if (x = 640) and (y = 480) then
			przenies <= '0';
			czasprzyspieszenia <= czasprzyspieszenia + 1;
			if(czasprzyspieszenia = "11111111") then
				przyspieszenie <= 0;
				czasprzyspieszenia <= "00000000";
			end if;
		end if;
	end if;
	
	if (koniec = '1') then
		bokA <= 20;
		punkty <= "00000";
	end if;
		
end if;
end process;



Wrog : process (clk) is
begin 
if rising_edge(clk) then
	if (x = 640) and (y = 480) then
		if(koniec = '0') then
			if (przenies = '0') then
				if ( pozycjawrogaX < pozycjakwadratuX) then
					pozycjawrogaX <= pozycjawrogaX + 1;
				else 
					pozycjawrogaX <= pozycjawrogaX - 1;
				end if;
			else
				pozycjawrogaX <= pozycjakwadratuX;
			end if;
			if ( pozycjawrogaY < pozycjakwadratuY) then
				pozycjawrogaY <= pozycjawrogaY + 1;
			else 
				pozycjawrogaY <= pozycjawrogaY - 1;
			end if;
		else
			pozycjawrogaX <= 400;
			pozycjawrogaY <= 400;
		end if;
	end if;
end if;
end process;



ZjedzeniePrzezWroga : process (clk) is
begin
if rising_edge(clk) then 
	if ((pozycjawrogaX + bokA) > pozycjakwadratuX) and (pozycjawrogaX < (pozycjakwadratuX + bokA)) and (pozycjawrogaY > (pozycjakwadratuY - bokA)) and ((pozycjawrogaY - bokA) < pozycjakwadratuY) then
		koniec <= '1';
	end if;
	if (x = 640) and (y = 480) then
		koniec <= '0';
	end if;
end if;
end process;



Wyswietlanie : process (clk, ruch, pozycjakwadratuX, pozycjakwadratuY) is
begin
if rising_edge(clk) then

	if (x < 640) and (y < 480) then
		
		if (x < (pozycjakwadratuX + bokA)) and (x > pozycjakwadratuX) and (y > (pozycjakwadratuY - bokA)) and (y < pozycjakwadratuY) then
			rgb <= "11111100";
		--if ((((x - pozycjakwadratuX) * (x - pozycjakwadratuX)) +((y - pozycjakwadratuY) * (y - pozycjakwadratuY))) < 169) then
		--	rgb <= "11111100";
				--if (( y < (x + pozycjakwadratuY - pozycjakwadratuX)) and ( y > ((-1 * x) + pozycjakwadratuY + pozycjakwadratuX))) then
					--rgb <= "00000000";
				--end if;	
		elsif (x < (pozycjajedzeniaX + bokjedzenia)) and (x > pozycjajedzeniaX) and (y > (pozycjajedzeniaY - bokjedzenia)) and (y < pozycjajedzeniaY) then
			if (pozycjajedzeniaY < 150) then
				rgb <= "11100011";
				kolor <= "01";
			elsif (pozycjajedzeniaY < 300) then
				rgb <= "00011010";
				kolor <= "10";
			else
				rgb <= "11100000";
				kolor <= "11";
			end if;
		elsif (x < (pozycjawrogaX + bokA)) and (x > pozycjawrogaX) and (y > (pozycjawrogaY - bokA)) and (y < pozycjawrogaY) then
			rgb <= "11001111";
		else
			rgb <= "00000000";
		end if;
		
	else
		rgb <= "00000000";
	end if;
	
end if;
end process;

display: entity display port map (wynik => wynik, segment => segment, enable => enable);


end Behavioral;