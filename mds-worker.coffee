
importScripts('util.js')
importScripts('lib/numeric-1.2.6.js')
importScripts('mds.js')
importScripts('gene-matrix.js')

@onmessage = (ev) ->
    if ev.data.init?
        #console.log "WORKER: Initialized!"
        @matrix = GeneMatrix.from_hash(ev.data.init)
    else if ev.data.msg?
        msg = ev.data.msg
        if msg.mds?
            range = msg.mds
            #our_log "WORKER: #{range}"
            comp = MDS.pca_gene(@matrix, range)
            postMessage(comp)
        else if msg.dist?
            range = msg.dist
            #our_log "WORKER: #{range}"
            dist_arr = Distance.distance(@matrix, range)
            postMessage(dist_arr)
        else
            our_log "WORKER:  Unknown method:",msg
    else
        our_log "WORKER:  Unknown message:",ev.data
