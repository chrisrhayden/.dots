run_init() {
    local no_ask source_file init_name

    init_name=.init.sh

    ls -al
    if [[ -f ${PWD}/${init_name} ]]; then
        no_ask="$1"
        source_file='no'

        # this allows any other value to fail and ask the user
        if [[ $no_ask == true ]]; then
            source_file='y'

        else
            if command -v bat &>/dev/null; then
                # a portable solution is
                #   bat_cmd="$(command -vp bat)"
                #   $bat_cmd --args "FILE"

                /usr/bin/bat \
                    --paging 'never' \
                    "${PWD}/${init_name}"

            else
                printf '>>>\n\n'
                /usr/bin/cat "${PWD}/${init_name}"
                printf '\n<<<\n'

            fi

            # for whatever fucking reason zsh does not use the same flag as bash
            # for the prompt, oh well
            printf ' source this file %s (y|N) > ' "${PWD}/${init_name}"
            read -r
            printf '\n'

            if [[ $REPLY == y ]] || [[ $REPLY == Y ]]; then
                source_file='y'
            fi
        fi

        if [[ $source_file == y ]]; then
            source "${PWD}/${init_name}"
        fi
    fi

    return 0
}

to() {
    local project_base project_name  whole_path base_name no_ask

    # set variables
    project_base="${HOME}/proj"

    project_name=''
    no_ask='false'

    while [[ -n $1 ]]; do
        case "$1"; in
            '.')
                project_name='.'
                ;;
            [a-z]*|[A-Z]*)
                project_name="${1%/}"
                ;;
            -n|--no-ask)
                no_ask='true'
                ;;
        esac
        shift
    done

    # if a . is given then try and run the .init.sh file
    if [[ $project_name == '.' ]]; then
        # just run the init and quit
        if ! run_init "$no_ask"; then
            return 1
        fi

        return 0
    fi

    # if the path exists
    if [[ -d $project_name ]]; then
        whole_path="${project_name}"

    # or if the path exists within the `project_base` directory
    # if no argument was given this resolves to `project_base` alone witch is nice
    elif [[ -d "${project_base}/${project_name}" ]]; then
        whole_path="${project_base}/${project_name}"

    else
        printf 'no project or directory named %s in %s\n' \
            "$project_name" "$project_base"

        return 1
    fi

    if ! cd "$whole_path"; then
        return 1
    fi

    if ! run_init "$no_ask"; then
        return 1
    fi

    return 0
}

_toproj_comp_bash() {
    local cur proj_dirs fll PROJ_H

    PROJ_H="${HOME}/proj"

    cur=${COMP_WORDS[COMP_CWORD]}

    proj_dirs=()

    for fll in "$PROJ_H"/*; do
        proj_dirs+=("${fll##*/}")
    done

    case "$cur" in
        *)
            # shellcheck disable=2207
            COMPREPLY=($(compgen -W "${proj_dirs[*]}" -- "${cur}"))
            ;;
    esac
}

if [[ -n ${ZSH_NAME} ]]; then
    # use the built in complete functions for zsh
    compdef '_files -W "${HOME}/proj"' to
else
    # call the above function to complete for to
    complete -F _toproj_comp_bash to
fi
