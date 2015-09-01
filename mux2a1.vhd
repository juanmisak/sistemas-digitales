library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2a1 is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           X   : out STD_LOGIC_VECTOR (3 downto 0));
end mux2a1;

architecture Behavioral of mux2a1 is
begin
    X <= A when (SEL = '1') else B;
end Behavioral;