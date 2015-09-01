library ieee;
use ieee.std_logic_1164.all;

package componentes is
	component sumador
		generic (n:INTEGER:=4); 
       	PORT (a : IN std_logic_vector(n-1 DOWNTO 0); 
              b : IN std_logic_vector(n-1 DOWNTO 0); 
              salida : OUT std_logic_vector(n-1 DOWNTO 0));
	end component;

	component contador_up
		generic (m:integer:=4);
		port(Resetn,Clock,En,Ld:in std_logic;
			 Ent:in std_logic_vector(m-1 downto 0);
			 Q:buffer std_logic_vector(m-1 downto 0));
	end component;

	component ram
		Port ( Clk : in std_logic; -- processing clock
			we 	 	: in std_logic; -- write enable signal
			wadd 	: in std_logic_vector(3 downto 0); -- write address to store the data into ram
			radd 	: in std_logic_vector(3 downto 0); -- read address to read the data from the ram
			data_in : in std_logic_vector(3 downto 0); -- input data to store into ram
			data_out: out std_logic_vector(3 downto 0)); -- output data from memory
	end component;

	component mux2a1
		Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           X   : out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
end componentes;

