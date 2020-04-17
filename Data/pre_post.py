def pre_post():
    a =open('C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/file.csv', 'r')
    for n,file in enumerate(a):
        if n ==2:
            actual_file = file.strip()
            actual_file = actual_file.replace('\"','')
    a.close()    

    b = open(actual_file, 'r')

    LIKERT_PRE = ()
    LIKERT_POST = ()
    for n,l in enumerate(b):
        if n == 298:
            LIKERT_PRE = (l)
        if n == 450:
            LIKERT_POST = (l)
    PRE = LIKERT_PRE.strip()[-1]
    POST = LIKERT_POST.strip()[-1]
    b.close()

    with open("C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/pre.csv",'w') as pre:
        pre.write(PRE)
        pre.close()

    with open("C:/Users/joaqu/OneDrive/Escritorio/702 Modeling and Representation of Data/Modeling_final_project/PROYECTO SOA/post.csv", 'w') as post:
        post.write(POST)
        post.close()

