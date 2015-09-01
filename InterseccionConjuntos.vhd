library ieee;
use ieee.std_logic_1164.all;
use work.componentes.all;

Entity InterseccionConjuntos is
	port(inA, inB: in std_logic_vector(0 to 7);
		  loadA, loadB, Start, Resetn, Clock: in std_logic;
		  Fin: out std_logic;
		  AIntB: out std_logic_vector(0 to 7);
		  Out1, Out2: out std_logic_vector(3 downto 0)
	);
end InterseccionConjuntos;

architecture comportamiento of InterseccionConjuntos is
	type estado is(a, b, c);
	signal y: estado;
	signal EnA, LdA, EnB, LdB, EnI, LdI:  std_logic;
	signal InContA, QcontA, InContB, QcontB: std_logic_vector(3 downto 0);
	--signal C_B, C_C: integer range 0 to 2;
	--signal C_BD: integer range 0 to 9;
	--signal DataDI, Bt: std_logic_vector(8 downto 0);
begin

--		process(Resetn, Clock)
--		begin
--			if Resetn= '0' then Fin <= '0';
--			elsif (Clock'event and Clock= '1') then
--				En1 <= '1';
--				Ld1 <= '1';
--			end if;
--		end process;


	mss_transiciones:
		process(Resetn, Clock)
		begin
			if Resetn= '0' then y<= a;
			elsif (Clock'event and Clock= '1') then
				case y is
					when a=>	EnA <= '1'; LdA <= '1'; 
								EnB <= '1'; LdB <= '1';
								EnI <= '1'; LdI <= '1';
								y <= b; 
								--if Start= '1' then y<= b;
								--else y<= a;
								--end if;
					when b=>	if(loadA = '1') then EnA <= '1'; 
								end if;
								Fin <= '1';
					when c=>	Fin <= '1';
				end case;
			end if;
		end process;
--		
--		mss_salidas:
--			process(y, Bt, Ld, Start, CB, CBD, CC)
--			begin
--				OK<= '0'; EnCC<= '0'; LdCC<= '0'; EnDt<= '0'; 
--				EnDI<= '0'; LdDI<= '0'; EnCBD<= '0'; LdCBD<= '0';
--				EnCB<= '0'; LdCB<= '0'; Gana<= '0';
--				case y is
--					when a=>	EnDI<= '1'; LdDI<= '1'; EnCBD<= '1'; LdCBD<= '1';
--								EnCC<= '1'; LdCC<= '1'; EnCB<= '1'; LdCB<= '1';
--								if (Start= '0' and Ld= '1') then EnDt<= '1';
--								else EnDI<= '1';
--								end if;
--					when b=>	EnDI<= '1'; EnCBD<= '1'; EnCC<= '1';
--								if Bt(8)= '1' then EnCB<= '1';
--								end if;
--								if CBD= '1' then Ok<='1';
--								end if;
--					when c=>	LdCC<= '1'; EnCC<= '1'; LdCB<= '1'; EnCB<= '1';
--					when e=>	Ok<= '1'; Gana<= '1';
--				end case;
--			end process;
			
		InContA <= "0000";
		InContB <= "0000";
		
		contador_up_A: contador_up
			port map (Resetn, Clock, EnA, LdA, InContA, Out1);
			
		contador_up_B: contador_up
			port map (Resetn, Clock, EnB, LdB, InContB, Out2);
	
end comportamiento;