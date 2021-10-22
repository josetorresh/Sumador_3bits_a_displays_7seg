library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity EJ3_V2 is
    Port ( ENTRADA_A : in  STD_LOGIC_VECTOR (2 downto 0);
           ENTRADA_B : in  STD_LOGIC_VECTOR (2 downto 0);
           --SALIDAS : out  STD_LOGIC_VECTOR (7 downto 0);
			  CLK : in  STD_LOGIC;
           SEGMENTOS : out  STD_LOGIC_VECTOR (7 downto 0);
           DISPLAYS : out  STD_LOGIC_VECTOR (7 downto 0)	);
end EJ3_V2;

architecture Behavioral of EJ3_V2 is
	
	signal PRIMER_SUMA : STD_LOGIC_VECTOR (3 downto 0);
	signal SEGUNDA_SUMA : STD_LOGIC_VECTOR (7 downto 0);
	signal DECENA,UNIDAD : STD_LOGIC_VECTOR (3 downto 0);
	signal CONTADOR : INTEGER range 0 to 100000;
	signal SELECTOR : STD_LOGIC_VECTOR (1 downto 0) :="00";
	signal MOSTRADOR : STD_LOGIC_VECTOR (1 downto 0) :="00";
	
	signal Num1,Num2 : STD_LOGIC_VECTOR (7 downto 0);
	
begin

	CONTADOR_CLK: PROCESS(CLK)
		BEGIN
			if rising_edge(CLK) then
				if CONTADOR < 100000 then
					CONTADOR <= CONTADOR + 1;
				else
					SELECTOR <= SELECTOR + 1;
					CONTADOR <= 0;   
				end if;
			end if;
		END PROCESS;
		
				Mostrar_Displays: PROCESS(SELECTOR,MOSTRADOR,Num1,Num2)
	BEGIN
		case SELECTOR is
			when "00" =>
				MOSTRADOR <= "10";
			when "01" =>
				MOSTRADOR <= "01";
			when others =>
				MOSTRADOR <= "11";
		end case;
		
		case MOSTRADOR is
			when "10" =>
				SEGMENTOS <= Num1;
			when "01" =>
				SEGMENTOS <= Num2;
			when others =>
				SEGMENTOS <= "11111111";
		end case;
	END PROCESS;
	

	process (ENTRADA_A,ENTRADA_B,PRIMER_SUMA,SEGUNDA_SUMA,DECENA,UNIDAD)
	begin
		PRIMER_SUMA <= '0' & ENTRADA_A + ENTRADA_B;
		
			if PRIMER_SUMA > "1001" then
				SEGUNDA_SUMA <= "0000" & PRIMER_SUMA + "110";
				DECENA <= SEGUNDA_SUMA(7 downto 4);
				UNIDAD <= SEGUNDA_SUMA(3 downto 0);
			else
				SEGUNDA_SUMA <= "0000" & PRIMER_SUMA + "110";
				DECENA <= "0000";
				UNIDAD <= PRIMER_SUMA(3 downto 0);
			end if;
			
	end process;
	
	process(DECENA,UNIDAD)
begin

         case UNIDAD is
            when "0000" => Num1 <= x"03";
            when "0001" => Num1 <= x"9F";
            when "0010" => Num1 <= x"25";
            when "0011" => Num1 <= x"0D";
            when "0100" => Num1 <= x"99";
            when "0101" => Num1 <= x"49";
            when "0110" => Num1 <= x"C1";
            when "0111" => Num1 <= x"1F";
				when "1000" => Num1 <= x"01";
				when "1001" => Num1 <= x"19";
            when others => Num1 <= x"FF";
         end case;
			
			case DECENA is
            when "0000" => Num2 <= x"03";
            when "0001" => Num2 <= x"9F";
            when "0010" => Num2 <= x"25";
            when "0011" => Num2 <= x"0D";
            when "0100" => Num2 <= x"99";
            when "0101" => Num2 <= x"49";
            when "0110" => Num2 <= x"C1";
            when "0111" => Num2 <= x"1F";
				when "1000" => Num2 <= x"01";
				when "1001" => Num2 <= x"19";
            when others => Num2 <= x"FF";
         end case;

end process;
DISPLAYS(7 downto 6) <= MOSTRADOR;
DISPLAYS(5 downto 0) <= "111111";

			
end Behavioral;
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
--
--entity EJ3_V2 is
--    Port ( ENTRADA_A : in  STD_LOGIC_VECTOR (2 downto 0);
--           ENTRADA_B : in  STD_LOGIC_VECTOR (2 downto 0);
--           SALIDAS : out  STD_LOGIC_VECTOR (7 downto 0));
--end EJ3_V2;
--
--architecture Behavioral of EJ3_V2 is
--	
--	signal PRIMER_SUMA : STD_LOGIC_VECTOR (3 downto 0);
--	signal SEGUNDA_SUMA : STD_LOGIC_VECTOR (7 downto 0);
--	
--begin
--
--	process (ENTRADA_A,ENTRADA_B,PRIMER_SUMA,SEGUNDA_SUMA)
--	begin
--		PRIMER_SUMA <= '0' & ENTRADA_A + ENTRADA_B;
--		
--			if PRIMER_SUMA > "1001" then
--				SEGUNDA_SUMA <= "0000" & PRIMER_SUMA + "110";
--				SALIDAS(7 downto 4) <= SEGUNDA_SUMA(7 downto 4);
--				SALIDAS(3 downto 0) <= SEGUNDA_SUMA(3 downto 0);
--			else
--				SEGUNDA_SUMA <= "0000" & PRIMER_SUMA + "110";
--				SALIDAS(7 downto 4) <= "0000";
--				SALIDAS(3 downto 0) <= PRIMER_SUMA(3 downto 0);
--			end if;
--			
--	end process;
--			
--end Behavioral;