library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;



entity ECEN474Project3 IS
			port( 
						switch      :signed(9 downto 0);
						button     :std_logic;
					  HEX0, HEX1, HEX2, HEX3  :out std_logic_vector(6 downto 0);
					 LEDR0,LEDR1,LEDR2,LEDR3,LEDR4,LEDR5,LEDR6,LEDR7		:inout std_logic
				);
end entity;


architecture Project3 of ECEN474Project3 IS
 signal num1 : signed (7 downto 0);
 signal num2 : signed (7 downto 0);
 signal num3 : signed (3 downto 0);
 signal num4 : signed(8 downto 0);
 signal rand			: signed(8 downto 0);
 signal add1 : signed (1 downto 0);
 signal add2 : signed (1 downto 0);
 signal add3 : signed (1 downto 0);
 signal T1, T2, T3 : integer range 0 to 9;
signal shs        : integer;
 


				component BINtoDEC IS							--component that takes in switch, outputs digits
	port (
        input_num : in signed(7 downto 0);
        digit_1 : out integer range 0 to 9;
        digit_2 : out integer range 0 to 9;
		  digit_3 : out integer range 0 to 9;
		  sign    : out integer
    );
end component;

type my_array_type is array (0 to 3) of signed(7 downto 0);
signal my_array : my_array_type := (others => (others => '0'));

begin
add1 <= switch(1 downto 0);							--stores the three addresses inputted by switches in these variables
add2 <= switch(3 downto 2);
add3 <= switch(9 downto 8);
rand <= num4(8 downto 0);
B1: BINtoDEC port map  (rand(7 downto 0),T1,T2,T3,shs);

process(button)
begin
if (button'event and button = '1') then							--process for using button to store output
if (add3 = "00") then										--if button is pressed, depending on value in last to switches, store the value
my_array(0) <= rand(7 downto 0);
elsif (add3 = "01") then
my_array(1) <= rand(7 downto 0);
elsif (add3 = "10") then
my_array(2) <= rand(7 downto 0);
elsif (add3 = "11") then
my_array(3) <= rand(7 downto 0);
else
end if;
end if;
end process;

process(my_array, switch)
begin

if (add1 = "00") then
num1 <= my_array(0);
elsif(add1 = "01") then
num1 <= my_array(1);
elsif(add1 = "10") then
num1 <= my_array(2);
elsif(add1 = "11") then
num1 <= my_array(3);
else 

end if;

if (add2 = "00") then
num2 <= my_array(0);
elsif(add2 = "01") then
num2 <= my_array(1);
elsif(add2 = "10") then
num2 <= my_array(2);
elsif(add2 = "11") then
num2 <= my_array(3);
else 
end if;

num3 <= switch(7 downto 4);

end process;


process(num3)
variable sig        : signed(8 downto 0);
begin
if (num3 = "0000") 	then
		sig  := ('0' & num1) + ('0' & num2);							--addition
elsif (num3 = "0001") 	then
		sig := ('0' & num1) - ('0' & num2);									--subtraction

elsif (num3 = "0010") then
		sig(7 downto 0) := num1 + 1 ;
elsif (num3 = "0011") then	
		sig(7 downto 0) := num1 - 1;																		--decrement
elsif (num3 = "0100") 	then
		sig(7 downto 0) := num1(6 downto 0) & '0';									--logical shift left
elsif (num3 = "0101") 	then
		sig(7 downto 0) := '0' & num1(7 downto 1);									--logical shift right
elsif (num3 = "0110") 	then
		sig(7 downto 0) := num1;									--pass A
elsif (num3 = "0111") 	then
		 sig(7 downto 0) := num2;													--left open (you can do whatever you want :))
elsif (num3 = "1000") 	then
			sig(7 downto 0)  := num1 and num2;									--bitwise and
elsif (num3 = "1001") 	then
			sig(7 downto 0) := num1 or num2;								--bitwise or
elsif (num3 = "1010") 	then
			sig(7 downto 0) := num1 xor num2;						   --bitwise XOR
elsif (num3 = "1011") 	then
			sig(7 downto 0) := 	not num1;													--1's complement (bitwise not)
elsif (num3 = "1100") 	then	
			sig(7 downto 0) := num1(6 downto 0) & num1(7);															--arithmetic shift left
elsif (num3 = "1101") 	then
			sig(7 downto 0)  := num1(0) & num1(7 downto 1);											--arithmetic shift right
elsif (num3 = "1110") 	then
			if num1 > num2 then
			LEDR1 <= '1';
			LEDR0 <= '0';
			elsif (num1 < num2) then                  --compare
			LEDR1 <= '0';
			LEDR0 <= '1';
			elsif (num1 = num2) then
			LEDR1 <= '1';
			LEDR0 <= '1';
			else
			end if;
elsif (num3 = "1111") 	then
												--another one left open ^.^
else

end if;
num4 <= sig (8 downto 0);
 end process;



process(T1,T2,T3,shs)		--maps each digit change to it's correct HEX counterpart
begin
			if (T1 = 0) 	then
			HEX0 <= "1000000";
		  elsif T1 = 1 	then
		   HEX0 <= "1111001";
		  elsif T1 = 2 	then
		   HEX0 <= "0100100";
		  elsif T1 = 3 	then
		   HEX0 <= "0110000";
		  elsif T1 = 4 	then
		  HEX0 <= "0011001";
		  elsif T1 = 5 	then
		  HEX0 <= "0010010";
		  elsif T1 = 6 	then
		  HEX0 <= "0000010";		  
		  elsif T1 = 7 	then
		  HEX0 <= "1111000";
		  elsif T1 = 8 	then
		  HEX0 <= "0000000";
		  elsif T1 = 9 	then
		  HEX0 <= "0011000";
		  else
		  
		  end if;
		  
					if (T2 = 0) then	
			HEX1 <= "1000000";
		  elsif T2 = 1 	then
		   HEX1 <= "1111001";
		  elsif T2 = 2 	then
		   HEX1 <= "0100100";
		  elsif T2 = 3 	then
		   HEX1 <= "0110000";
		  elsif T2 = 4 	then
		  HEX1 <= "0011001";
		  elsif T2 = 5 	then
		  HEX1 <= "0010010";
		  elsif T2 = 6 	then
		  HEX1 <= "0000010";		  
		  elsif T2 = 7 	then
		  HEX1 <= "1111000";
		  elsif T2 = 8 	then
		  HEX1 <= "0000000";
		  elsif T2 = 9 	then
		  HEX1 <= "0011000";
		  else
		  
		  end if;
		  
			if (T3 = 0) 	then
			HEX2<= "1000000";
		  elsif T3 = 1 	then
		   HEX2 <= "1111001";
		  elsif T3 = 2 	then
		   HEX2 <="0100100";
		  elsif T3 = 3 	then
		   HEX2 <= "0011000";
		  elsif T3 = 4 	then
		  HEX2 <= "0011001";
		  elsif T3 = 5 	then
		  HEX2 <= "0010010";
		  elsif T3 = 6 	then
		  HEX2 <= "0000010";		  
		  elsif T3 = 7 	then
		  HEX2 <= "1111000";
		  elsif T3 = 8 	then
		  HEX2 <= "0000000";
		  elsif T3 = 9 	then
		  HEX2 <= "0011000";
		  else
		  
		  end if;
		  
		  if (shs = 1) 	 then
		  HEX3 <= "0111111";
		  
		  elsif (shs = 0) 	then
		  HEX3 <= "1111111";

		  end if;
end process;

process(rand)
 begin
 
 
 
 
 
 		if (rand(7) = '1') then				--check for negative
		LEDR2 <= '0';
		LEDR3 <= '1';
		LEDR4  <= '0';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '0';
		else
		LEDR2 <= '1';
		LEDR3 <= '0';
		LEDR4  <= '0';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '0';
		end if;
		
		if (rand = "000000000") then
		LEDR2 <= '0';
		LEDR3 <= '0';
		LEDR4  <= '1';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '0';
		end if;
		
		
		
		if (num3 = "0001") then
			
		if (rand(7) = '0') then
		LEDR2 <= '1';
		LEDR3 <= '0';
		LEDR4  <= '0';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '0';
		
		elsif (rand(7) = '1') then
		LEDR2 <= '0';
		LEDR3 <= '1';
		LEDR4  <= '0';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '1';
		end if;
		end if;
		
		if (rand(8) = '1') then
		LEDR2 <= '0';
		LEDR3 <= '0';
		LEDR4  <= '0';
		LEDR5   <= '0';
		LEDR6	 <= '0';
		LEDR7   <= '1';
		
		end if;
		
		if (rand(7) xor rand(6) xor rand(5) xor rand(4) xor rand(3) xor rand(2) xor rand(1) xor rand(0)) = '1' then
		LEDR6 <= '1';
		else
		LEDR6 <= '0';
		end if;
 end process;


end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity BINtoDEC is												--binary to decimal component
    port (
        input_num : in signed(7 downto 0);
        digit_1 : out integer range 0 to 9;
        digit_2 : out integer range 0 to 9;
		  digit_3 : out integer range 0 to 9;
		  sign    : out integer

    );
end entity;

architecture Behavioral of BINtoDEC is
    signal decimal_num : integer range 0 to 255;
begin
																		--converts unsigned binary to decimal

    decimal_num <= to_integer(unsigned(input_num));			

    process(decimal_num)
        variable Dig1 : integer range 0 to 9;
        variable Dig2 : integer range 0 to 9;
		  variable Dig3 : integer range 0 to 9;
		  variable sig        : integer;
		  variable temp1       : integer range 0 to 255;
    begin
	
		
		
			if(input_num(7) = '0') 	then	--if positive
			temp1 := to_integer(unsigned(input_num(6 downto 0)));	--same as previous
		  Dig1 := temp1 mod 10;
        Dig2 := (temp1 mod 100) /10;
		  Dig3 := (temp1 mod 1000) /100;

        digit_1 <= Dig1;
        digit_2 <= Dig2;
		  digit_3 <= Dig3;
		  sig := 0;
		  
			elsif (input_num(7) = '1') 	then			--if negative
			if (input_num(6 downto 0) = "000000") then
				digit_1 <= 8;					-- -128 special condition
				digit_2 <= 2;
				digit_3 <= 1;
				sig := 1;
			else
		temp1 := (to_integer(unsigned(not input_num(6 downto 0) + 1)));
										--if negative and not special condition, do 2's complement
		  Dig1 := temp1 mod 10;
        Dig2 := (temp1 mod 100) /10;
		  Dig3 := (temp1 mod 1000) /100;

        digit_1 <= Dig1;
        digit_2 <= Dig2;
		  digit_3 <= Dig3;
		  sig := 1;
		  
		  
				end if;
				
				
				
		end if;
		
		
		  sign <= sig;				--output sign bit
		end process;  
		  
		 
end architecture;