--例4-2多路选择器
entity mux21a is
  port (
    a,b:in bit;
    s:in bit;
    q:out bit
  ) ;
end entity mux21a;

architecture behave of mux21a is
begin
    q<=(a and (not s))or(b and s);
end architecture behave ; -- behave


----------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity time_pulse is
  port (
    clk,start,step,stop:in std_logic;
    p:out std_logic_vector(3 downto 0)
  ) ;
end time_pulse;

architecture a of time_pulse is

    signal count:std_logic_vector(4 downto 0):="00000";
    signal count1:std_logic_vector(4 downto 0):="00000";
    signal temp:std_logic_vector(3 downto 0):="0000";
    signal temp1:std_logic_vector(3 downto 0):="0000";
    signal sta,rst:std_logic;
    signal sta1:std_logic;
begin
    t1 : process( clk )
    begin
        if rising_edge(clk) then
            if start='0' then
                sta<='1';
            elsif stop<='0' then
                sta<='0';
            end if ;
        end if ;
    end process t1;

    t2 : process( clk )
    begin
        if rising_edge(clk) then
            if sta='1' then
                count(0)<='1';
                for i in 0 to 3 loop
                    count(i+1)<=count(i);
                    if count(i+1)='1' then
                        count(i)<='0';
                    end if ;
                    temp(i)<=count(i) and count(i+1);
                end loop ;
            else
                count<="00000";
                temp<="0000";  
          end if;
        end if ;
    end process t2;

    t4 : process( sta )
    begin
        if sta='1' then
            p<=not temp;
        else
            p<="1111";
        end if ;
    end process t4; -- t4

end a ; -- a