library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SomadorVetorial is
    Port (
        A_i        : in  STD_LOGIC_VECTOR (31 downto 0);
        B_i        : in  STD_LOGIC_VECTOR (31 downto 0);
        vecSize_i : in  STD_LOGIC_VECTOR (1 downto 0); -- 00->4, 01->8, 10->16, 11->32
        mode_i    : in  STD_LOGIC; -- Soma: 0 | Subtracao: 1
        S_o       : out STD_LOGIC_VECTOR (31 downto 0)
    );
end SomadorVetorial;

architecture arq_SomadorVetorial of SomadorVetorial is

signal c_G      : STD_LOGIC_VECTOR (31 downto 0); -- Carry Generate
signal c_P      : STD_LOGIC_VECTOR (31 downto 0); -- Carry Propagate
signal c_C      : STD_LOGIC_VECTOR (31 downto 0); -- Carry
signal aux_B    : STD_LOGIC_VECTOR (31 downto 0); -- B auxiliar
signal aux_Soma : STD_LOGIC_VECTOR (31 downto 0); -- Soma auxiliar

begin

-- Seleciona soma ou subtracao (complemento de dois)
aux_B <= B_i when (mode_i = '0') else
         not(B_i);

-- Calculo dos sinais Generate e Propagate
generate_GP: for i in 0 to 31 generate
    c_G(i) <= A_i(i) and aux_B(i);
    c_P(i) <= A_i(i) xor aux_B(i);
end generate generate_GP;

-- Carry inicial
c_C(0) <= '0' when (mode_i = '0') else
          '1';

-- (Demais sinais de carry conforme implementacao original)
-- Codigo extenso mantido integralmente no relatorio

-- Calculo da soma final
generate_soma: for j in 0 to 31 generate
    S_o(j) <= (A_i(j) xor aux_B(j)) xor c_C(j);
end generate generate_soma;

end arq_SomadorVetorial;