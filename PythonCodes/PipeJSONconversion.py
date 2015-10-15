# -*- coding: utf-8 -*-
"""
Created on Mon Jun 08 13:51:39 2015
Fugro GeoServices - TU Delft
GRADUATION THESIS: Solid CAD geometries in a Spatial DBMS. An application in the petrochemical industy.
@author: M.G.W. Ramkisoen
"""
def reader(file_):
    # This function reads a txt or sql file and converts it to single elements.
    fh = open(file_)
    inp = 'PJ20_'
    inp = inp + str(file_)
    inp = inp + '.sql'
    contents = fh.read()
    contents = contents.split('\n')
    contents = formatter(contents, inp)
    return contents
    
def formatter(line,ret):
    # This function formats the Pipe JSON to Pipe JSON 2.1
    count = 0    
    a = len(line)
    a = a - 1
    
    #File opening
    f = open(ret,'w')
    
    # Assigning Geometry to single or multi 
    while count != a:
        geo = line[count]
        
        #Retrieve JSON
        temp_ac = 0
        
        while geo[temp_ac] != '{':
            temp_ac += 1
            
        if geo[temp_ac-1] == '[':
            #Grouped Geo
            temp_ac -= 1           
            newelement = diff(geo, temp_ac)
        else:
            #single GEO
            b = 0
            
            while geo[temp_ac+b] != ',':
                b += 1
            
            b += 2
            temp_ac += b
            newelement = simple(geo, temp_ac)
        
        newelement += '\n'        
        f.write(newelement)
        count += 1
    
    #Closing file
    f.close()   
    return "completed"
 
def simple(geo, que):
    #Create new element with other needed information (single geometry)
    newelement = geo[:que]
    newelement += 'Attributes":[{"'
    
    endque = 0
    
    while geo[que+endque]!=' ':
        endque += 1

    newelement += geo[que:que+endque-3]
    newelement += '}]'
    newelement += geo[que+endque-3:]
    return newelement
    
def diff(geo, que):
    #Create new element with other needed information (more geometries)
    newelement = geo[:que]
    
    ending = 0
    
    while geo[que+ending]!=',':
        ending += 1
        
    newelement += geo[que+1:que+ending+2]
    newelement += 'Attributes":[{"'
    
    endque = 0
    
    while geo[que+ending+endque]!=']':
        endque += 1
        
    newelement += geo[que+ending+2:que+ending+endque+1]
    newelement += '}'
    newelement += geo[que+ending+endque+1:]

    return newelement
    
def _test():
    # You can use this method to test this conversion script
    print reader('pipes_xx-xx-xxxx_X.sql')
    
if __name__ == '__main__':
    _test()
