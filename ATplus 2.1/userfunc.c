#include "usertab.c"
#include "dymtable.c"


int Rafamessage(char* digues){
DymosimMessage(digues);
return 1;}
int Rafaerror(char* digues){
DymosimError(digues);
return 1;}

double AT_read_next(double tableID, int icolIn, double u) {
      int     ID, nt1, nt2, icol, nipo, colWise, iu, iuMax;
      double *table, u1, u2, y1, y2;
      icol = round(icolIn);
      ID   = round(tableID);
      if ( ID < 0  ||  ID > lastTableID ) {
         sprintf(amatError, "ID (= %d) of a table is not in the range 0 .. %d\n",
                 ID, (int) max(0,lastTableID));
         goto ERROR;
      }

      colWise = dymTable[ID].colWise;
      nipo    = dymTable[ID].nipo;
      nt1     = dymTable[ID].dim[0];
      nt2     = dymTable[ID].dim[1];
      table   = dymTable[ID].table;
      if ( nipo != 1 ) {
         sprintf(amatError, "Table \"%s(%d,%d)\" is not defined for 1D-interpolation\n"
                            "(table defined for %dD-interpolation).\n",
                            dymTable[ID].tableName, nt1, nt2, nipo);
         goto ERROR;
      } else if ( icol < 2  ||  icol > nt2 ) {
         sprintf(amatError, "Table \"%s(%d,%d)\" is used for 1D-interpolation\n"
                            "in column %d, which is out of range.\n",
                            dymTable[ID].tableName, nt1, nt2, icol);
         goto ERROR;
      }

      if ( nt1 <= 1 ) return ( tableGet(1,icol) );

      iu    = dymTable[ID].last[0];
      iuMax = nt1 - 1;
      while ( iu < iuMax  &&  u > tableGet(iu+1,1) ) iu++;
      while ( iu > 1      &&  u < tableGet(iu  ,1) ) iu--;

      u1 = tableGet(iu  ,   1);
      u2 = tableGet(iu+1,   1);
      y1 = tableGet(iu  ,icol);
      y2 = tableGet(iu+1,icol);

      dymTable[ID].last[0] = iu;

      if ( u1 >= u2 ) {
         sprintf(amatError,"The values of the first column of table \"%s(%d,%d)\" are\n"
                           "NOT STRICT monotonically increasing because\n"
                           "   %s(%d,1) (=%e) >=\n"
                           "   %s(%d,1) (=%e).\n",
                           dymTable[ID].tableName, nt1, nt2, dymTable[ID].tableName,
                           iu, u1, dymTable[ID].tableName, iu+1, u2 );
         goto ERROR;
      }

      return y2;

      ERROR: DymosimError(amatError);
             return 0.0;
}
double AT_read_previous(double tableID, int icolIn, double u) {

      int     ID, nt1, nt2, icol, nipo, colWise, iu, iuMax;
      double *table, u1, u2, y1, y2;

      icol = round(icolIn);
      ID   = round(tableID);
      if ( ID < 0  ||  ID > lastTableID ) {
         sprintf(amatError, "ID (= %d) of a table is not in the range 0 .. %d\n",
                 ID, (int) max(0,lastTableID));
         goto ERROR;
      }

      colWise = dymTable[ID].colWise;
      nipo    = dymTable[ID].nipo;
      nt1     = dymTable[ID].dim[0];
      nt2     = dymTable[ID].dim[1];
      table   = dymTable[ID].table;
      if ( nipo != 1 ) {
         sprintf(amatError, "Table \"%s(%d,%d)\" is not defined for 1D-interpolation\n"
                            "(table defined for %dD-interpolation).\n",
                            dymTable[ID].tableName, nt1, nt2, nipo);
         goto ERROR;
      } else if ( icol < 2  ||  icol > nt2 ) {
         sprintf(amatError, "Table \"%s(%d,%d)\" is used for 1D-interpolation\n"
                            "in column %d, which is out of range.\n",
                            dymTable[ID].tableName, nt1, nt2, icol);
         goto ERROR;
      }

      if ( nt1 <= 1 ) return ( tableGet(1,icol) );

      iu    = dymTable[ID].last[0];
      iuMax = nt1 - 1;
      while ( iu < iuMax  &&  u > tableGet(iu+1,1) ) iu++;
      while ( iu > 1      &&  u < tableGet(iu  ,1) ) iu--;

      u1 = tableGet(iu  ,   1);
      u2 = tableGet(iu+1,   1);
      y1 = tableGet(iu  ,icol);
      y2 = tableGet(iu+1,icol);

      dymTable[ID].last[0] = iu;

      if ( u1 >= u2 ) {
         sprintf(amatError,"The values of the first column of table \"%s(%d,%d)\" are\n"
                           "NOT STRICT monotonically increasing because\n"
                           "   %s(%d,1) (=%e) >=\n"
                           "   %s(%d,1) (=%e).\n",
                           dymTable[ID].tableName, nt1, nt2, dymTable[ID].tableName,
                           iu, u1, dymTable[ID].tableName, iu+1, u2 );
         goto ERROR;
      }

       return y1;

      ERROR: DymosimError(amatError);
             return 0.0;
}
