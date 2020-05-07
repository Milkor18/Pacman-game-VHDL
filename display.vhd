
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity display is
    Port ( punkty : in unsigned(3 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0);
			  clk : in std_logic;
           enable : out  STD_LOGIC_VECTOR (2 downto 0));
end display;

architecture Behavioral of display is

begin
Wyswietlpunkty : process ( punkty) is
begin
	enable <= "110";

	case punkty is
		when "0000" => segment <= "00000010";
		when "0001" => segment <= "10011110";
		when "0010" => segment <= "00100100";
		when "0011" => segment <= "00001100";
		when "0100" => segment <= "10011000";
		when "0101" => segment <= "01001000";
		when "0110" => segment <= "01000000";
		when "0111" => segment <= "00011110";
		when "1000" => segment <= "00000000";
		when "1001" => segment <= "00011000" ;
		when "1010" => segment <= "00010000";
		when "1011" => segment <= "11000000";
		when "1100" => segment <= "01100010";
		when "1101" => segment <= "10000100";
		when "1110" => segment <= "01100000";
		when others => segment <= "01110000" ;
	end case;

end process;

end Behavioral;

