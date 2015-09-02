	
end comportamiento;
library ieee;
use ieee.std_logic_1164.all;
use work.componentes.all;

Entity InterseccionConjuntos is
	port(
			inA, inB: in std_logic_vector(3 downto 0);
			loadA, loadB, Start, Resetn, Clock, VerAIntB, Si: in std_logic;
			Fin: out std_logic;
			AIntB: out std_logic_vector(3 downto 0);
			Out1, Out2: out std_logic_vector(3 downto 0)
	);
end InterseccionConjuntos;

architecture comportamiento of InterseccionConjuntos is
	type estado is(a, b, c, d, e, f, g);
	signal y: estado;
	signal EnA, LdA, EnB, LdB, EnI, LdI, EnCountInt, LdContInt, EnCounti, LdConti, EnCountj, LdContj:  std_logic;
	signal SRamA, ModoRamA, SRamB, ModoRamB, EnCountk, LdContk, SRamInt, ModoRamInt, menorA, igualA, mayorA, menorB, igualB, mayorB:  std_logic;
	signal menori, iguali, mayori, menorj, igualj, mayorj, menorAB, igualAB, mayorAB:  std_logic;
	signal InContA, QcontA, InContB, QcontB, InContInt, QcontInt, InConti, Qi, InContj, Qj, AddRamA, QRamA: std_logic_vector(3 downto 0);
	signal AddRamB, QRamB, InContk, Qk, AddRamInt, QRamInt: std_logic_vector(3 downto 0);
begin
	process(Resetn, Clock)
	begin
		if Resetn = '0' then y <= a;
		elsif (Clock'event and Clock = '1') then
			case y is
				when a=>	EnA <= '1'; LdA <= '1'; 
							EnB <= '1'; LdB <= '1';
							EnCountInt <= '1'; LdCountInt <= '1';
							EnCounti <= '1'; LdCounti <= '1';
							EnCountj <= '1'; LdCountj <= '1';
							if(loadA = '1') then
								ModoRamA = '1';
								EnA = '1';
								y <= b; 
							end if;
				when b=>	if(menorA = '1') then
								if(loadA = '1') then
									ModoRamA = '1';
									EnA = '1';
									if(Start = '1') then
										y <= c;
									end if;
								end if;
							else
								y <= c;
							end if;
				when c=>	if(loadB = '1') then
								ModoRamB = '1';
								EnB = '1';
								y <= d; 
							end if;
				when d=>	if(menorB = '1') then
								if(loadB = '1') then
									ModoRamB = '1';
									EnB = '1';
									if(Start = '1') then
										y <= e;
									end if;
								end if;
							else
								y <= e;
							end if;
				when e=> 	SRamA = '1';
							SRamB = '1';
							if(menori = '0') then
								y <= g
							else
								if(igualAB = '1') then
									ModoRamInt = '1';
									EnContInt = '1';
								end if;
								y <= f;
							end if;
				when f=> 	EnCountj = '1';
							if(menorj = '0') then
								EnCountj = '1';
								LdCountj = '1';
								EnCounti = '1';
							end if;
							y <= e;
				when g=>	if (menork = '1') then
								if (VerAIntB = '1')
									AIntB <= 
									Fin <= 1;
								end if;
								if (S)
							end if;
							y <= a;							
			end case;
		end if;
	end process;
	InContA <= "0000";
	InContB <= "0000";
	InContInt <= "0000";
	InConti <= "0000";
	InContj <= "0000";
	InContk <= "0000";
	contador_up_A: contador_up port map (Resetn, Clock, EnA, LdA, InContA, QcontA);
	contador_up_B: contador_up port map (Resetn, Clock, EnB, LdB, InContB, QcontB);
	contador_up_Int: contador_up port map (Resetn, Clock, EnCountInt, LdContInt, InContInt, QcontInt);
	contador_up_i: contador_up port map (Resetn, Clock, EnCounti, LdConti, InConti, Qi);
	contador_up_j: contador_up port map (Resetn, Clock, EnCountj, LdContj, InContj, Qj);
	contador_up_k: contador_up port map (Resetn, Clock, EnCountk, LdContk, InContk, Qk);
	ram_A: ram port map (Clock, ModoRamA, AddRamA, AddRamA, inA, QRamA);
	mux_addRamA: mux2a1	port map (SRamA, Qi, QcontA, AddRamA);
	ram_B: ram port map (Clock, ModoRamB, AddRamB, AddRamB, inB, QRamB);
	mux_addRamB: mux2a1 port map (SRamB, Qj, QcontB, AddRamB);
	ram_Int: ram port map (Clock, ModoRamInt, AddRamInt, AddRamInt, QRamB, QRamInt);
	mux_addRamInt: mux2a1 port map (SRamInt, Qk, QcontInt, AddRamInt);
	comparador_A: comparador port map (QcontA, "1010", menorA, igualA, mayorA);
	comparador_B: comparador port map (QcontB, "1010", menorB, igualB, mayorB);
	comparador_i: comparador port map (Qconti, QcontA, menori, iguali, mayori);
	comparador_j: comparador port map (Qcontj, QcontB, menorj, igualj, mayorj);	
	comparador_AB: comparador port map (QRamA, QRamB, menorAB, igualAB, mayorAB);	
end comportamiento;