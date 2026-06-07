import 'package:flutter/material.dart';
import 'dart:async'; // Necessário para o Timer do carrossel

// Ponto de entrada principal do aplicativo
void main() => runApp(const MeuApp());

// ============================================================================
// WIDGET RAIZ DO APLICATIVO
// ============================================================================
class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: TelaPrincipal(), 
    );
  }
}

// ============================================================================
// CONTEINER PRINCIPAL (Gerencia a navegação e o cabeçalho)
// ============================================================================
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // Guarda o índice da tela atualmente selecionada
  int _currentIndex = 0;
  
  // NOVA VARIÁVEL: Guarda a tela anterior para que o botão 'X' saiba para onde voltar
  int _previousIndex = 0;

  // Lista com as 5 telas do aplicativo
  final List<Widget> _telas = const [
    TelaInicio(), // Índice 0
    TelaPlaceholder(titulo: 'Nenhuma consulta marcada ainda\n(Em Breve...)'), // Índice 1
    TelaNovaConsulta(), // Índice 2 (AGORA IMPLEMENTADA)
    TelaPlaceholder(titulo: 'Nenhum exame agendado ainda\n(Em Breve...)'), // Índice 3
    TelaPerfil(), // Índice 4
  ];

  // --- INÍCIO DO BUILD (TELA PRINCIPAL) ---
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE6F0FC);

    return Scaffold(
      backgroundColor: backgroundColor,
      
      body: Column(
        children: [
          // CONTAINER DO CABEÇALHO DINÂMICO
          Container(
            color: Colors.white, 
            width: double.infinity, 
            child: SafeArea(
              bottom: false, 
              child: _buildCabecalhoDinamico(), 
            ),
          ),
          
          // CONTEÚDO DAS TELAS 
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _telas,
            ),
          ),
        ],
      ),

      bottomNavigationBar: _buildBarraNavegacaoCustomizada(),
    );
  }
  // --- FIM DO BUILD (TELA PRINCIPAL) ---

  // ============================================================================
  // FUNÇÃO: CABEÇALHO DINÂMICO
  // ============================================================================
  Widget _buildCabecalhoDinamico() {
    // 1. SE ESTIVER NA TELA DE NOVA CONSULTA (ÍNDICE 2), OCULTA O CABEÇALHO
    // O protótipo mostra que as abas ocupam o topo da tela nessa seção.
    if (_currentIndex == 2) {
      return const SizedBox.shrink(); 
    }

    // 2. SE ESTIVER NA TELA DE PERFIL (ÍNDICE 4), MOSTRA CABEÇALHO EXPANDIDO
    if (_currentIndex == 4) {
      return Container(
        height: 190,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.menu, size: 35, color: Color(0xFF005f6B)),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xff0068E0),
                    child: Icon(Icons.person, color: Colors.white, size: 60),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lúcio Mugiwara',
                    style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 3. CABEÇALHO PADRÃO PARA AS DEMAIS TELAS (Índices 0, 1, 3)
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Color(0xFF00C6B5), size: 28),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xff0068E0),
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Olá, Lúcio!',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // FUNÇÃO: BARRA DE NAVEGAÇÃO CUSTOMIZADA
  // ============================================================================
  Widget _buildBarraNavegacaoCustomizada() {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          _buildItemNavegacao(0, Icons.home_outlined, Icons.home_filled, 'Início'),
          _buildItemNavegacao(1, Icons.medical_services_outlined, Icons.medical_services, 'Consultas'),
          _buildBotaoAgendar(), // O botão central animado
          _buildItemNavegacao(3, Icons.favorite_border, Icons.favorite, 'Exames'),
          _buildItemNavegacao(4, Icons.person_outline, Icons.person, 'Perfil'),
        ],
      ),
    );
  }

  // --- INÍCIO DA FUNÇÃO: CRIAR ITEM DA NAVEGAÇÃO ---
  Widget _buildItemNavegacao(int index, IconData iconeInativo, IconData iconeAtivo, String label) {
    bool isSelected = _currentIndex == index; 
    const corAtiva = Color(0xFF00796B); 

    return GestureDetector(
      onTap: () { 
        setState(() {
          // Se não estiver indo para o botão central, atualizamos também o _previousIndex para referência futura
          if (index != 2) _previousIndex = index;
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque, 
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? iconeAtivo : iconeInativo,
              size: 28,
              color: isSelected ? corAtiva : Colors.black87,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? corAtiva : Colors.black87,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600, 
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // --- FIM DA FUNÇÃO: CRIAR ITEM DA NAVEGAÇÃO ---

  // --- INÍCIO DA FUNÇÃO: BOTÃO AGENDAR (CENTRAL ANIMADO) ---
  Widget _buildBotaoAgendar() {
    bool isSelected = _currentIndex == 2;
    const corTeal = Color(0xFF00796B);
    const corVermelha = Color(0xFFFF0000); // Vermelho vibrante para cancelar

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            // Se já está na tela de agendar (X vermelho ativado), ele cancela e volta pra tela anterior
            _currentIndex = _previousIndex;
          } else {
            // Se vai abrir o agendamento, salva onde estava antes
            _previousIndex = _currentIndex;
            _currentIndex = 2;
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ANIMAÇÃO DE COR E FORMATO
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected ? corVermelha : corTeal, // Muda de Teal para Vermelho
                shape: BoxShape.circle, 
                boxShadow: [ 
                  if (isSelected) 
                    BoxShadow(color: corVermelha.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)
                ]
              ),
              padding: const EdgeInsets.all(9),
              // ANIMAÇÃO DE ROTAÇÃO: 0.375 turns = 135 graus (Faz o símbolo de '+' virar um 'x')
              child: AnimatedRotation(
                turns: isSelected ? 0.375 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.add, size: 50, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // --- FIM DA FUNÇÃO: BOTÃO AGENDAR ---
}


// ============================================================================
// TELA 2: NOVA CONSULTA (IMPLEMENTAÇÃO DO PROTÓTIPO)
// ============================================================================
class TelaNovaConsulta extends StatefulWidget {
  const TelaNovaConsulta({super.key});

  @override
  State<TelaNovaConsulta> createState() => _TelaNovaConsultaState();
}

class _TelaNovaConsultaState extends State<TelaNovaConsulta> {
  // Variável para controlar o estado do switch (Exames anteriores)
  bool _temExamesAnteriores = false;

  // Guarda a especialidade médica selecionada (pode ser nula se nenhuma for selecionada)
  String? _especialidadeSelecionada;
  
  // Variáveis para guardar data e hora selecionadas
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;


  @override
  Widget build(BuildContext context) {
    const corAzulEscuro = Color(0xff0068E0);
    const corAzulClaro = Color(0xFFE0F2FE);
    const corTeal = Color(0xFF00C6B5);

    // DefaultTabController gerencia o estado das abas superiores
    return DefaultTabController(
      length: 2, // Temos duas abas: "Nova consulta" e "Novo exame"
      child: Scaffold(
        backgroundColor: const Color(0xFFE6F0FC),
        body: Column(
          children: [
            // BARRA DE ABAS SUPERIOR (TabBar)
            Container(
              height: 60,
              color: Colors.white,
              child: const TabBar(
                indicatorColor: corTeal, // Linha indicador embaixo da aba ativa
                indicatorWeight: 3,
                labelColor: corTeal, // Cor do texto ativo
                unselectedLabelColor: Colors.black87, // Cor do texto inativo
                labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                tabs: [
                  Tab(text: 'Nova consulta'),
                  Tab(text: 'Novo exame'),
                ],
              ),
            ),

            
            
            // CONTEÚDO DAS ABAS
            Expanded(
              child: TabBarView(
                children: [
                  
                  // =================== ABA 1: NOVA CONSULTA ===================
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // 1. LOCAL DA CONSULTA
                        const Text('Local da Consulta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: corAzulEscuro)),
                        const SizedBox(height: 10),
                        Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('UBS Bairro do Carmo', style: TextStyle(color: Color(0xFF005f6B), fontWeight: FontWeight.w700, fontSize: 16)),
                                      SizedBox(height: 4),
                                      Text('Rua Nossa Senhora do Carmo, 000\nBairro do Carmo, São Roque-SP', style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4)),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: corAzulClaro,
                                    foregroundColor: corAzulEscuro,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: const Text('Alterar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 2. ESPECIALIDADE MÉDICA
                        const Text('Especialidade médica', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: corAzulEscuro)),
                        const SizedBox(height: 10),
                        Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Escolha uma das opções', style: TextStyle(color: corTeal, fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 10),
                                _buildEspecialidadeItem('Clínico Geral'),
                                const Divider(color: Colors.grey, height: 1),
                                _buildEspecialidadeItem('Pediatra'),
                                const Divider(color: Colors.grey, height: 1),
                                _buildEspecialidadeItem('Ginecologista'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 3. DATA E HORÁRIO (Lado a lado)
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: _buildDataHorarioCard('Data', 'Escolha uma data\ndisponível', 'data')),
                              const SizedBox(width: 20),
                              Expanded(child: _buildDataHorarioCard('Horário', 'Escolha um horário\ndisponível', 'hora')),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 4. EXAMES ANTERIORES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exames anteriores', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: corAzulEscuro)),
                            // Toggle Switch
                            Switch(
                              value: _temExamesAnteriores,
                              activeColor: Colors.white,
                              activeTrackColor: corTeal,
                              onChanged: (bool value) {
                                setState(() {
                                  _temExamesAnteriores = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Possui algum exame realizado anteriormente para mostrar ao médico? Se sim, leve-o para a consulta.', style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4)),
                                const SizedBox(height: 10),
                                Text(
                                  _temExamesAnteriores ? 'Sim, levarei um exame.' : 'Não, eu não tenho um exame para mostrar.', 
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // 5. BOTÃO MARCAR CONSULTA
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: corAzulEscuro,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text('Marcar a consulta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // =================== ABA 2: NOVO EXAME (Placeholder) ===================
                  const Center(child: Text('Formulário de Novo Exame em breve...', style: TextStyle(fontSize: 16, color: Colors.black54))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FUNÇÕES AUXILIARES DA TELA NOVA CONSULTA ---
  
  // Constrói os itens da lista de especialidades
  // Constrói os itens da lista de especialidades (Agora clicáveis e de seleção única)
  Widget _buildEspecialidadeItem(String titulo) {
    bool isSelected = _especialidadeSelecionada == titulo;
    const corTeal = Color(0xFF00C6B5); // Cor de destaque para o item selecionado

    return InkWell(
      onTap: () {
        setState(() {
          // Ao clicar, a variável global recebe o título deste item exato
          _especialidadeSelecionada = titulo;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo, 
              style: TextStyle(
                fontSize: 15, 
                // Se estiver selecionado, fica com a cor Teal e em negrito
                color: isSelected ? corTeal : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              )
            ),
            // Se estiver selecionado, exibe um ícone de check à direita
            if (isSelected)
              const Icon(Icons.check_circle, color: corTeal, size: 20),
          ],
        ),
      ),
    );
  }

  // Constrói os cards idênticos de Data e Horário
  Widget _buildDataHorarioCard(String titulo, String subtitulo, String tipo) {
    String textoSelecionado = '';
    
    if (tipo == 'data' && _dataSelecionada != null) {
      textoSelecionado = '${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}';
    } else if (tipo == 'hora' && _horaSelecionada != null) {
      textoSelecionado = '${_horaSelecionada!.hour.toString().padLeft(2, '0')}:${_horaSelecionada!.minute.toString().padLeft(2, '0')}';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Text(
                  textoSelecionado.isEmpty ? subtitulo : textoSelecionado,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: textoSelecionado.isEmpty ? Colors.black : const Color(0xff0068E0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (tipo == 'data') {
                      final DateTime? dataSelecionada = await showDatePicker(
                        context: context,
                        initialDate: _dataSelecionada ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (dataSelecionada != null) {
                        setState(() => _dataSelecionada = dataSelecionada);
                      }
                    } else if (tipo == 'hora') {
                      final TimeOfDay? horaSelecionada = await showTimePicker(
                        context: context,
                        initialTime: _horaSelecionada ?? TimeOfDay.now(),
                      );
                      if (horaSelecionada != null) {
                        setState(() => _horaSelecionada = horaSelecionada);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0F2FE),
                    foregroundColor: const Color(0xff0068E0),
                    elevation: 0,
                    minimumSize: const Size(80, 36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Alterar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// TELA 1: INÍCIO (DASHBOARD) - RESTAURADA DO CÓDIGO ANTERIOR
// ============================================================================
class TelaInicio extends StatelessWidget {
  const TelaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    const cardColor = Colors.white;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Boas vindas!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
          const SizedBox(height: 10),
          Card(
            color: cardColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Unidade de Saúde selecionada:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF005f6B))),
                  const SizedBox(height: 8),
                  const Text('UBS Bairro do Carmo', style: TextStyle(fontSize: 14, color: Colors.black)),
                  const Text('Rua Nossa Senhora do Carmo, 000', style: TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE0F2FE), foregroundColor: const Color(0xff0068E0), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        child: const Text('Mais detalhes'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff0068E0), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        child: const Text('Trocar unidade'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const CarrosselDestaques(),
          const SizedBox(height: 24),
          const Text('Acesso rápido', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickAccessCard(context, Icons.local_hospital_outlined, 'UBSs'),
                _buildQuickAccessCard(context, Icons.apartment_outlined, 'Hospitais'),
                _buildQuickAccessCard(context, Icons.assignment_outlined, 'Receitas médicas'),
                _buildQuickAccessCard(context, Icons.campaign_outlined, 'Campanhas'),
                _buildQuickAccessCard(context, Icons.info_outline, 'Informações'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Próximo evento', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
          const SizedBox(height: 10),
          Card(
            color: cardColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('Nenhuma consulta ou exame foi agendada ainda.', style: TextStyle(fontSize: 14, color: Colors.black54))),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(BuildContext context, IconData icon, String label) {
    return Container(
      width: 105, height: 140, margin: const EdgeInsets.only(right: 8.0),
      child: Card(
        color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: const Color(0xFF005F6B)),
              const SizedBox(height: 30),
              Text(label, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET: CARROSSEL DE IMAGENS AUTOMÁTICO - RESTAURADO
// ============================================================================
class CarrosselDestaques extends StatefulWidget {
  const CarrosselDestaques({super.key});

  @override
  State<CarrosselDestaques> createState() => _CarrosselDestaquesState();
}

class _CarrosselDestaquesState extends State<CarrosselDestaques> {
  final PageController _pageController = PageController(initialPage: 0);
  int _paginaAtual = 0;
  Timer? _timer;
  final List<Map<String, String>> _itensDestaque = [
    {'imagemUrl': 'assets/images/banner_novembro_azul.png'},
    {'imagemUrl': 'assets/images/banner_farmacia_popular.png'},
    {'imagemUrl': 'assets/images/banner_autismo.png'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_paginaAtual < _itensDestaque.length - 1) {
        _paginaAtual++;
      } else {
        _paginaAtual = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(_paginaAtual, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.47,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _itensDestaque.length,
            onPageChanged: (int page) => setState(() => _paginaAtual = page),
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  _itensDestaque[index]['imagemUrl']!, fit: BoxFit.cover, width: double.infinity, height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_itensDestaque.length, (index) {
            return Container(
              width: 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: _paginaAtual == index ? const Color(0xff0068E0) : Colors.grey[400]),
            );
          }),
        ),
      ],
    );
  }
}

// ============================================================================
// TELA 5: PERFIL - RESTAURADA
// ============================================================================
class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Informações Pessoais', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
          const SizedBox(height: 10),
          Card(
            color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Data de nascimento', '06 de dezembro de 1970'), const SizedBox(height: 16),
                  _buildProfileItem('Telefone', '(11) 40028922'), const SizedBox(height: 16),
                  _buildProfileItem('Email', 'mugiwaranolucy@gmail.com'), const SizedBox(height: 16),
                  _buildProfileItem('CPF', '401.222.098.06'), const SizedBox(height: 16),
                  _buildProfileItem('Cartão Nacional de Saúde (CNS)', '456123789012011'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Endereço', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xff0068E0))),
          const SizedBox(height: 10),
          Card(
            color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Endereço residencial', '05090-970\nRua dos Bobos, nº 0\nVila do Chaves\nTangamandápio-SP'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF005f6B))), const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4)), 
      ],
    );
  }
}

// ============================================================================
// WIDGET ESPAÇADOR TEMPORÁRIO
// ============================================================================
class TelaPlaceholder extends StatelessWidget {
  final String titulo;
  const TelaPlaceholder({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54)),
    );
  }
}