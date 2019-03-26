module vectorDot
    using SymEngine
    export vecSym, dot
    struct vecSym <: Number
        name::String
        function vecSym(x::String)
            new(x)
        end
    end

    function Base.show(io::IO, vec::vecSym)
        print(io, ("\033[1m"*vec.name*"\x1b[0m"))
                   # Black \033[1m;Oringe:\x1b[1;31m;normal:\x1b[0m
    end

    struct scalarTimes
        scalar::Basic
        vec::vecSym
        function scalarTimes(x::Basic,y::vecSym)
            new(x,y)
        end
    end
    function Base.show(io::IO, y::scalarTimes)
        print(io,y.scalar,y.vec)
    end
    struct vecAdd
        veca
        function vecAdd(x)
            new(x)
        end
    end

    function Base.show(io::IO, y::vecAdd)
        print(io, "+","(",y.veca,")")
    end

    import Base.*
    *(x::Basic,y::vecSym)= scalarTimes(x,y)
    import Base.+
    +(x::vecSym,y::vecSym)= vecAdd((x,y))
    +(x::vecSym,y...)= vecAdd((x,y...))
    +(x::scalarTimes,y::vecSym)= vecAdd((x,y))
    +(x::scalarTimes,y::scalarTimes)= vecAdd((x,y))
    +(x::scalarTimes,y...)= vecAdd((x,y...))
    +(x::Tuple)= vecAdd(x)

    function dot(x::vecSym,y::vecSym)
        xn=x.name;
        yn=y.name;
        if x.name<y.name 
            return symbols("$x"*"⋅"*"$y")
        else
            return symbols("$y"*"⋅"*"$x")
        end
    end

    function dot(x::scalarTimes,y::vecSym)
        x.scalar*dot(x.vec,y)
    end
    function dot(y::vecSym,x::scalarTimes)
        dot(x::scalarTimes,y::vecSym)
    end
    function dot(x::vecAdd,y::vecSym)
        xx = x.veca;
        s=0;
        for i=1:length(xx)
           s+=dot(xx[i],y)
        end
        return s
    end
    function dot(y::vecSym,x::vecAdd)
        dot(x::vecAdd,y::vecSym)
    end
    function dot(x::vecAdd,y::vecAdd)
        yy = y.veca;
        s=0;
        for i=1:length(yy)
           s+=dot(x,yy[i])
        end
        return s
    end
    function dot(x::vecAdd,y::scalarTimes)
       y.scalar*dot(x,y.vec)
    end
    function dot(x::Tuple, y::vecSym)
        # s = 0
       # for i in x
       #    s+=dot(x[i],y)
       # end
        s = 0
        for i=1:length(x)
           s+=dot(x[i],y)
        end
        return s
    end
end