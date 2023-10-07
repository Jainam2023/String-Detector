

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(6 downto 0);
       	output_vector: out std_logic_vector(0 downto 0));
end entity;

architecture DutWrap of DUT is

component words is
port( inp:in std_logic_vector(4 downto 0);
reset,clock:in std_logic;
outp: out std_logic);
end component words;
begin


   add_instance: words port map (inp => input_vector(6 downto 2), reset => input_vector(1),
												clock => input_vector(0),
											   Outp => output_vector(0));

end DutWrap;

