/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  2.1.1                                 |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
//    
//             __
//      ______|  |
//    d|         |D
//     |______   |
//        b   |__|
//             s
//    
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

changecom(//)changequote([,])
 
define(calc, [esyscmd(perl -e 'printf ($1)')])

meshGenApp blockMesh;
convertToMeters 0.001; //it means that you have type all measures in "mm"

//=======================user defined datas==================================//
define(d, 34.83)			// feeding diameter
define(dratio, 1.5)			// diameter ratio (D/d)
define(sa, 0.02999)			// dimensionless gap between reed and seat (sa=s/d)
define(b, calc(1*d))		        // feeding tube length
define(theta, 2)			// angle between front/backface and plane x-y
define(Ref, 1)				// Refinement level


//Number of Grids (G) and Expation Ratios (ER) 
define(Gxdif, 45)
define(ERxdif, 1.842)

define(Gydif, 90)
define(ERydif, 17.25)

define(Gxtube, 100)
define(ERxtube, 220)

define(Gytube, 110)
define(ERytube, 83.2)

define(Gz, 1)

//===========================================================================//

//=====================datas manipulation====================================//

define(PI, 3.14159265)
define(sintheta, calc(sin((PI/180)*theta)))
define(costheta, calc(cos((PI/180)*theta))) 
define(D, calc(d*dratio))  
define(R, calc(D/2.0))
define(r, calc(d/2.0))
define(s, calc(sa*d))
define(sm, calc(s/2.0))

   
define(zr, calc(r*sintheta))
define(yr, calc(r*costheta))

define(zrR, calc((((R-r)/2)+r)*sintheta))
define(yrR, calc((((R-r)/2)+r)*costheta))

define(zR, calc(R*sintheta))
define(yR, calc(R*costheta))

//==========================================================================//

  vertices
   (

	(0  0  0) //00
	(sm  0  0) //01
	(s  0  0) //02
	(calc(s+b)  0  0) //03

	(0  yr  -zr) //04
	(sm  yr  -zr) //05
	(s  yr  -zr) //06
	(calc(s+b)  yr  -zr) //07

	(0  yrR  -zrR) //08
	(sm  yrR  -zrR) //09
	(s  yrR  -zrR) //10

	(0  yR  -zR) //11
	(sm  yR  -zR) //12
	(s  yR  -zR) //13


	(0  yr  zr) //14
	(sm  yr  zr) //15
	(s  yr  zr) //16
	(calc(s+b)  yr  zr) //17

	(0  yrR  zrR) //18
	(sm  yrR  zrR) //19
	(s  yrR  zrR) //20

	(0  yR  zR) //21
	(sm  yR  zR) //22
	(s  yR  zR) //23



   );
				
   blocks
   (

    // blocks with 6 vertices

	hex (2 3 7 6 2 3 17 16) (Gxtube Gytube Gz) simpleGrading (ERxtube calc(1/ERytube) 1) //0
	hex (1 2 6 5 1 2 16 15) (Gxdif Gytube Gz) simpleGrading (calc(1/ERxdif) calc(1/ERytube) 1) //1
	hex (0 1 5 4 0 1 15 14) (Gxdif Gytube Gz) simpleGrading (ERxdif calc(1/ERytube) 1) //2

    //blocks with 8 vertice

	hex (5 6 10 9 15 16 20 19) (Gxdif Gydif Gz) simpleGrading (calc(1/ERxdif) ERydif 1) //3
	hex (4 5 9 8 14 15 19 18) (Gxdif Gydif Gz) simpleGrading (ERxdif ERydif 1) //4
	hex (9 10 13 12 19 20 23 22) (Gxdif Gydif Gz) simpleGrading (calc(1/ERxdif) calc(1/ERydif) 1) //5
	hex (8 9 12 11 18 19 22 21) (Gxdif Gydif Gz) simpleGrading (ERxdif calc(1/ERydif) 1) //6
   );

   edges
   (
 
   );

   boundary             
    (
 	inlet              
        {
            type inlet;    
            faces
            (
                (3 3 7 17) 
		
            );
        }                  

        outlet             
        {
            type outlet;    
            faces
            (
               (13 12 22 23)
               (12 11 21 22)

            );
        }


       reed-wall
       {
            type wall;
            faces
            (

               (0 0 14 4)
               (4 14 18 8)
               (8 18 21 11)

            );
        }

       walls
       {
            type wall;
            faces
            (

		(7 6 16 17)
	        (6 10 20 16)
	        (10 13 23 20)

            );
        }

       frontWedge
       {
            type wedge;
            faces
            (

		(3 2 6 7)
	        (2 1 5 6)
	        (1 0 4 5)
	        (6 5 9 10)
	        (5 4 8 9)
	        (10 9 12 13)
	        (9 8 11 12)

            );
        }

       backWedge
       {
            type wedge;
            faces
            (
		(2 3 17 16)
	        (1 2 16 15)
	        (0 1 15 14)
	        (15 16 20 19)
	        (14 15 19 18)
	        (19 20 23 22)
	        (18 19 22 21)

            );
        }


    ); 

   mergePatchPairs
   (
   );



// ************************************************************************* //
