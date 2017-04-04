//explicita
float WorldSize = 10.0;
int ArraySize = 128;
float DX = WorldSize / ArraySize;
int PixelsPerCell = 4;
int WindowWidth = PixelsPerCell * ArraySize;
int WindowHeight = 700;
//----------Declarem els vectors------------ 
float[] vector_ant = new float[ArraySize]; //Correspon a h(m)
float[] vector_ant2 = new float[ArraySize]; //Correspon a h(m-1)
float[] vector = new float[ArraySize]; //Correspon a h(m+1)

//----------Funció del MÈTODE EXPLÍCIT-------------------
void Timestep(float mu)
{
for (int j=1;j<ArraySize-1;++j) 
{
  vector [j] = 2*vector_ant[j] - vector_ant2[j] + mu* (vector_ant[j+1]- 2*vector_ant[j]+vector_ant[j-1]);
}
vector[0]=vector[1];
vector[ArraySize-1]=vector[ArraySize-2];
vector_ant2=vector_ant; //Actualitza el vector h(m-1)=h(m) per passar a la següent iteració
vector_ant=vector; //Actualitza el vector h(m)=h(m+1) per passar a la següent iteració
}

//----------Funció que inicialitza els vectors-------------------
void setup()
{
  
   size( WindowWidth, WindowHeight );
    for (int i=0;i<ArraySize;++i)
    {
    vector[i]=0.1;
    vector_ant[i]=0.1;
    vector_ant2[i]=0.1;
    }
    
    colorMode( RGB, 1.0 );
    strokeWeight( 0.5 );  
}

//---------------Funcions que dibuixen-------------------
void DrawState()
{
float OffsetY = 0.5 * ( float )WindowHeight;
for ( int i = 0; i < ArraySize; ++i )
{
float SimX = DX * ( float )i;
float PixelsX = ( float )( i * PixelsPerCell );
float SimY = vector[i];
float PixelsY = SimY * (( float )PixelsPerCell ) / DX;
float PixelsMinY = OffsetY - PixelsY;
float PixelsHeight = (( float )WindowHeight) - PixelsMinY;
fill( 0.0, 0.0, 1.0 );
rect( PixelsX, OffsetY - PixelsY, PixelsPerCell, PixelsHeight );
}
}

void draw()
{
   background( 0.9 );
   GetInput();
   Timestep(0.5);
   DrawState();
}

//Funció que permet interactuar amb les ones i inicialitzar el moviment manualment
void GetInput()
{
    if ( mousePressed && mouseButton == LEFT )
    {
    float mouseCellX = mouseX / ( ( float )PixelsPerCell );
    float mouseCellY = ( (height/2) - mouseY ) / ( ( float )PixelsPerCell );
    float simY = mouseCellY * DX;
    int iX = ( int )floor( mouseCellX + 0.5 );
      if ( iX > 0 && iX < ArraySize-1 )
      {
        vector[iX] = simY;
      }
    }
}
