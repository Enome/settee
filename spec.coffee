db = ( require './setup/db' )

{ deploy } = ( require './setup/deploy' )
{ Settee } = ( require './' )

deploy ->

  settee = ( Settee.bind null, db, 'general' )

  products = settee
    type:'product'
    options: { descending: true }
    queries:
      'by email':
        view: 'findProductByEmail'
        map: (data)-> data.value
        options: { key: 'info@example.com' }


  # Create

  save = products.save [ { name: 'This was just a test' }, { email: 'info@example.com' } ]

  save.on 'complete', (data)->

    console.log '--- save -->', data


    # Query

    query = products.query 'by email'

    query.on 'one', (data)->

      console.log '--- one -->', data

      # Remove

      remove = products.remove data

      remove.on 'complete', (data)->

        console.log '--- remove -->', data

      remove.commit()

    query.on 'many', (data)->

      console.log '--- many -->', data

    query.on 'empty', ->

      console.log '--- empty -->'

    query.on 'error', (error)-> console.log 'query', error

    query.commit()


  save.on 'error', (error)-> console.log 'error', error

  save.commit()
