// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0; 
 
contract Pessoa { 
 
    address public cartorioAddress; 
 
    constructor(address _cartorioAddress) { 
        cartorioAddress = _cartorioAddress; 
    } 
 
    function CriarRG() public { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        cartorio.GerarRG(address(this)); 
    } 
 
    function TirarCNH() public { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        cartorio.GerarCNH(address(this)); 
    } 
 
    function pedidoCasamento(address conjuge) public { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        cartorio.PedidoCasamento(address(this), conjuge); 
    } 
 
    function queryRG(address consulta) public view returns (uint) { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        return cartorio.GetRG(consulta); 
    } 
 
    function queryCNH(address consulta) public view returns (uint) { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        return cartorio.GetCNH(consulta); 
    } 
 
    function queryParceiro(address consulta) public view returns (address) { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        return cartorio.GetCasado(consulta); 
    } 
 
    function queryPedido(address consulta) public view returns (address) { 
        Cartorio cartorio = Cartorio(cartorioAddress); 
        return cartorio.GetPedidoCasamento(consulta); 
    } 
} 
 
// Contrato Cartorio 
contract Cartorio { 
 
    uint private counterRG = 0;  
    uint private counterCNH = 0;  
 
    mapping(address => uint) public rgs; 
    mapping(address => uint) public cnh; 
    mapping(address => address) public casados; 
    mapping(address => address) public pedidosCasamento; 
    mapping(address => uint) public mortos; 
 
    function GetRG(address pessoaAddress) public view returns (uint) { 
        return rgs[pessoaAddress]; 
    } 
 
    function GetCNH(address pessoaAddress) public view returns (uint) { 
        return cnh[pessoaAddress]; 
    } 
 
    function GetCasado(address pessoaAddress) public view returns (address) { 
        return casados[pessoaAddress]; 
    } 
 
    function GetPedidoCasamento(address pessoaAddress) public view returns (address) { 
        return pedidosCasamento[pessoaAddress]; 
    } 
 
    function GetMorto(address pessoaAddress) public view returns (uint) { 
        return mortos[pessoaAddress]; 
    } 
 
    function GerarRG(address pessoaAddress) public { 
        require(rgs[pessoaAddress] == 0, "RG already generated for this person"); 
        counterRG = counterRG + 1; 
        rgs[pessoaAddress] = counterRG; 
    } 
 
    function GerarCNH(address pessoaAddress) public { 
        require(cnh[pessoaAddress] == 0, "CNH already generated for this person"); 
        counterCNH = counterCNH + 1; 
        cnh[pessoaAddress] = counterCNH; 
    } 
 
    function PedidoCasamento(address pessoaAddress, address conjuge) public { 
        require(casados[pessoaAddress] == address(0), "Nao pode ja estar casado"); 
        require(pedidosCasamento[pessoaAddress] == address(0), "ja existe um pedido aberto"); 
        require(casados[conjuge] == address(0), "conjuge ja casado"); 
        pedidosCasamento[pessoaAddress] = conjuge; 
        if(pedidosCasamento[conjuge] == pessoaAddress){ 
            casados[pessoaAddress] = conjuge; 
            casados[conjuge] = pessoaAddress; 
            pedidosCasamento[pessoaAddress] = address(0); 
            pedidosCasamento[conjuge] = address(0); 
        } 
    } 
 
    function AnularPedido(address pessoaAddress) public returns (string memory) { 
        if(pedidosCasamento[pessoaAddress] != address(0)){ 
            pedidosCasamento[pessoaAddress] = address(0); 
            return "pedido cancelado com sucesso"; 
        } 
        return "Nenhum pedido ativo"; 
    } 
}
