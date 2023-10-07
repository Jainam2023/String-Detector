library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity words is
port( inp:in std_logic_vector(4 downto 0);
reset,clock:in std_logic;
outp: out std_logic);
end words;
architecture bhv of words is
---------------Define state type here-----------------------------
type state is (rst,s1,s2,s3,s4); -- Fill other states here
---------------Define signals of state type-----------------------
signal yp1,yn1,yp2,yn2,yp3,yn3: state:=rst;
begin

clock_proc:process(clock,reset)
begin
	if(clock='1' and clock' event) then
	if(reset='1') then
	yp1 <= rst;
	yp2<=rst;
	yp3<=rst;
	else
	yp1 <= yn1;
	yp2 <= yn2; 
	yp3 <= yn3; 
	end if;
	end if;
end process;

bomb_proc:process(inp,yp1)
begin
	case yp1 is
		when rst =>
			if(unsigned(inp)=2) then --b has been detected
			yn1 <= s1; 
			else
			yn1 <= rst;
			end if;
		when s1 =>
			if(unsigned(inp)=15) then --o has been detected
			yn1 <= s2; 
			else
			yn1 <= s1;
			end if;
		when s2 =>
			if(unsigned(inp)=13) then --m has been detected
			yn1 <= s3; 
			else
			yn1 <= s2;
			end if;
		when s3 =>
			if(unsigned(inp)=2) then --b has been detected
			yn1 <= s1; 
			else
			yn1 <= s3;
			end if;
		when s4 =>
			yn1 <= s4;
	end case;
end process;

gun_proc:process(inp,yp2)
begin
	case yp2 is
		when rst =>
			if(unsigned(inp)=7) then --g has been detected
			yn2 <= s1; 
			else
			yn2 <= rst;
			end if;
		when s1 =>
			if(unsigned(inp)=21) then --u has been detected
			yn2 <= s2; 
			else
			yn2 <= s1;
			end if;
		when s2 =>
			if(unsigned(inp)=14) then --n has been detected
			yn2 <= s3; 
			else
			yn2 <= s2;
			end if;
		when s3 =>
			if(unsigned(inp)=7) then --g has been detected
			yn2 <= s1; 
			else
			yn2 <= s3;
			end if;
		when s4 =>
			yn2 <= s4;
	end case;
end process;

roam_proc:process(inp,yp3)
begin
	case yp3 is
		when rst =>
			if(unsigned(inp)=18) then --r has been detected
			yn3 <= s1; 
			else
			yn3 <= rst;
			end if;
		when s1 =>
			if(unsigned(inp)=15) then --o has been detected
			yn3 <= s2; 
			else
			yn3 <= s1;
			end if;
		when s2 =>
			if(unsigned(inp)=1) then --a has been detected
			yn3 <= s3; 
			else
			yn3 <= s2;
			end if;
		when s3 =>
			if(unsigned(inp)=13) then --m has been detected
			yn3 <= s4; 
			else
			yn3 <= s3;
			end if;
		when s4 =>
			if(unsigned(inp)=18) then --r has been detected
			yn3 <= s1; 
			else
			yn3 <= s4;
			end if;
	end case;
end process;

output_proc:process(inp,yp1,yp2,yp3)
begin
	if ((unsigned(inp) = 2 and yp1 = s3) or (unsigned(inp) = 14 and yp2 = s2) or (unsigned(inp) = 13 and yp3 = s3)) then 
	outp <= '1';
	else 
	outp <= '0';
	end if;
end process output_proc;
end bhv; 

